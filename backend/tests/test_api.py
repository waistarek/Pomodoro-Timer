import os
import sys
from pathlib import Path
from datetime import datetime, timedelta

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

os.environ["DATABASE_URL"] = "sqlite:///./test_pomodoro.db"
os.environ["JWT_SECRET"] = "test-secret"
os.environ["CORS_ORIGINS"] = "http://localhost:8080"

from fastapi.testclient import TestClient  # noqa: E402
from app.database import Base, engine  # noqa: E402
from app.main import app  # noqa: E402

client = TestClient(app)


def setup_function():
    Base.metadata.drop_all(bind=engine)
    Base.metadata.create_all(bind=engine)


def register_and_login():
    client.post("/auth/register", json={"email": "test@example.com", "password": "12345678"})
    response = client.post("/auth/login", json={"email": "test@example.com", "password": "12345678"})
    assert response.status_code == 200
    token = response.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}


def test_register_login_and_me():
    headers = register_and_login()
    response = client.get("/users/me", headers=headers)
    assert response.status_code == 200
    assert response.json()["email"] == "test@example.com"


def test_task_crud():
    headers = register_and_login()
    response = client.post(
        "/tasks",
        headers=headers,
        json={"title": "Lernen", "description": "Flutter", "priority": "high", "tags": "flutter,python", "completed": False},
    )
    assert response.status_code == 201
    task_id = response.json()["id"]

    response = client.get("/tasks", headers=headers)
    assert response.status_code == 200
    assert len(response.json()) == 1

    response = client.put(f"/tasks/{task_id}", headers=headers, json={"completed": True})
    assert response.status_code == 200
    assert response.json()["completed"] is True

    response = client.delete(f"/tasks/{task_id}", headers=headers)
    assert response.status_code == 204


def test_sessions_and_stats():
    headers = register_and_login()
    start = datetime.utcnow() - timedelta(minutes=25)
    end = datetime.utcnow()
    response = client.post(
        "/sessions",
        headers=headers,
        json={
            "client_session_id": "test-session-stats-1",
            "task_id": None,
            "phase_type": "work",
            "duration_minutes": 25,
            "completed": True,
            "started_at": start.isoformat(),
            "ended_at": end.isoformat(),
        },
    )
    assert response.status_code == 201

    response = client.get("/stats/daily", headers=headers)
    assert response.status_code == 200
    assert response.json()["total_pomodoros"] >= 1
    assert response.json()["total_focus_minutes"] >= 25


def test_settings_update():
    headers = register_and_login()
    response = client.get("/settings", headers=headers)
    assert response.status_code == 200
    assert response.json()["work_minutes"] == 25

    payload = response.json()
    payload.update({"work_minutes": 30, "theme": "dark"})
    response = client.put("/settings", headers=headers, json=payload)
    assert response.status_code == 200
    assert response.json()["work_minutes"] == 30
    assert response.json()["theme"] == "dark"


def test_task_stats_grouped_by_task():
    headers = register_and_login()

    task_response = client.post(
        "/tasks",
        headers=headers,
        json={
            "title": "Mathe lernen",
            "description": "",
            "priority": "medium",
            "tags": "",
            "completed": False,
        },
    )
    assert task_response.status_code == 201
    task_id = task_response.json()["id"]

    start = datetime.utcnow() - timedelta(minutes=60)
    end = datetime.utcnow()

    response = client.post(
        "/sessions",
        headers=headers,
        json={
            "client_session_id": "test-session-task-stats-1",
            "task_id": task_id,
            "phase_type": "work",
            "duration_minutes": 60,
            "completed": True,
            "started_at": start.isoformat(),
            "ended_at": end.isoformat(),
        },
    )
    assert response.status_code == 201

    response = client.get("/stats/tasks", headers=headers)
    assert response.status_code == 200

    data = response.json()
    assert data["total_focus_minutes"] == 60
    assert data["total_pomodoros"] == 1
    assert data["items"][0]["task_id"] == task_id
    assert data["items"][0]["task_title"] == "Mathe lernen"
    assert data["items"][0]["focus_minutes"] == 60


def test_tasks_include_completed_pomodoros():
    headers = register_and_login()

    task_response = client.post(
        "/tasks",
        headers=headers,
        json={
            "title": "Mathe lernen",
            "description": "",
            "priority": "medium",
            "tags": "",
            "completed": False,
        },
    )
    assert task_response.status_code == 201
    task_id = task_response.json()["id"]

    start = datetime.utcnow() - timedelta(minutes=25)
    end = datetime.utcnow()

    session_response = client.post(
        "/sessions",
        headers=headers,
        json={
            "client_session_id": "test-session-task-count-1",
            "task_id": task_id,
            "phase_type": "work",
            "duration_minutes": 25,
            "completed": True,
            "started_at": start.isoformat(),
            "ended_at": end.isoformat(),
        },
    )
    assert session_response.status_code == 201

    tasks_response = client.get("/tasks", headers=headers)
    assert tasks_response.status_code == 200

    tasks = tasks_response.json()
    assert tasks[0]["id"] == task_id
    assert tasks[0]["completed_pomodoros"] == 1


def test_daily_stats_uses_berlin_timezone():
    headers = register_and_login()

    response = client.post(
        "/sessions",
        headers=headers,
        json={
            "client_session_id": "test-session-timezone-1",
            "task_id": None,
            "phase_type": "work",
            "duration_minutes": 25,
            "completed": True,
            "started_at": "2026-05-24T21:30:00Z",
            "ended_at": "2026-05-24T22:30:00Z",
        },
    )
    assert response.status_code == 201

    response = client.get("/stats/daily", headers=headers)
    assert response.status_code == 200

    data = response.json()
    labels = {item["label"]: item for item in data["items"]}

    # 22:30 UTC ist in Deutschland 00:30 am Folgetag.
    assert labels["2026-05-25"]["pomodoros"] == 1

from datetime import datetime, timezone
from app.stats import _local_date


def test_local_date_converts_utc_to_berlin_date():
    dt = datetime(2026, 5, 24, 22, 30, tzinfo=timezone.utc)

    assert _local_date(dt, "Europe/Berlin").isoformat() == "2026-05-25"

def test_create_session_is_idempotent_by_client_session_id():
    headers = register_and_login()

    payload = {
        "client_session_id": "test-session-123",
        "task_id": None,
        "phase_type": "work",
        "duration_minutes": 25,
        "completed": True,
        "started_at": datetime.utcnow().isoformat(),
        "ended_at": datetime.utcnow().isoformat(),
    }

    first = client.post("/sessions", headers=headers, json=payload)
    assert first.status_code == 201

    second = client.post("/sessions", headers=headers, json=payload)
    assert second.status_code == 201

    assert first.json()["id"] == second.json()["id"]

    sessions = client.get("/sessions", headers=headers)
    assert sessions.status_code == 200
    assert len(sessions.json()) == 1