import os
from fastapi import Depends, FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from .database import Base, engine, get_db
from .deps import get_current_user
from sqlalchemy import func
from .models import PomodoroSession, Setting, Task, User
from sqlalchemy.exc import IntegrityError
from .schemas import (
    SessionCreate,
    SessionRead,
    SettingsBase,
    SettingsRead,
    StatsResponse,
    TaskCreate,
    TaskRead,
    TaskUpdate,
    Token,
    UserCreate,
    UserLogin,
    UserRead,
    TaskStatsResponse,
)
from .security import create_access_token, hash_password, verify_password
from .stats import build_stats, build_task_stats

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Pomodoro API", version="1.0.0")

origins_raw = os.getenv("CORS_ORIGINS", "http://localhost:3000,http://localhost:8080,http://127.0.0.1:8080")
origins = [origin.strip() for origin in origins_raw.split(",") if origin.strip()]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


def _get_or_create_settings(db: Session, user_id: int) -> Setting:
    settings = db.query(Setting).filter(Setting.user_id == user_id).first()
    if settings is None:
        settings = Setting(user_id=user_id)
        db.add(settings)
        db.commit()
        db.refresh(settings)
    return settings


@app.post("/auth/register", response_model=UserRead, status_code=201)
def register(data: UserCreate, db: Session = Depends(get_db)) -> User:
    existing = db.query(User).filter(User.email == data.email.lower()).first()
    if existing:
        raise HTTPException(status_code=409, detail="E-Mail ist bereits registriert")
    user = User(email=data.email.lower(), password_hash=hash_password(data.password))
    db.add(user)
    db.commit()
    db.refresh(user)
    _get_or_create_settings(db, user.id)
    return user


@app.post("/auth/login", response_model=Token)
def login(data: UserLogin, db: Session = Depends(get_db)) -> Token:
    user = db.query(User).filter(User.email == data.email.lower()).first()
    if user is None or not verify_password(data.password, user.password_hash):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Falsche E-Mail oder falsches Passwort")
    return Token(access_token=create_access_token(str(user.id)))


@app.get("/users/me", response_model=UserRead)
def get_me(current_user: User = Depends(get_current_user)) -> User:
    return current_user


@app.get("/tasks", response_model=list[TaskRead])
def list_tasks(current_user: User = Depends(get_current_user), db: Session = Depends(get_db)) -> list[dict]:
    tasks = (
        db.query(Task)
        .filter(Task.user_id == current_user.id)
        .order_by(Task.created_at.desc())
        .all()
    )

    pomodoro_counts = dict(
        db.query(PomodoroSession.task_id, func.count(PomodoroSession.id))
        .filter(
            PomodoroSession.user_id == current_user.id,
            PomodoroSession.completed.is_(True),
            PomodoroSession.phase_type == "work",
            PomodoroSession.task_id.isnot(None),
        )
        .group_by(PomodoroSession.task_id)
        .all()
    )

    return [
        {
            "id": task.id,
            "user_id": task.user_id,
            "title": task.title,
            "description": task.description,
            "priority": task.priority,
            "tags": task.tags,
            "completed": task.completed,
            "created_at": task.created_at,
            "completed_pomodoros": int(pomodoro_counts.get(task.id, 0)),
        }
        for task in tasks
    ]

@app.post("/tasks", response_model=TaskRead, status_code=201)
def create_task(data: TaskCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)) -> Task:
    task = Task(user_id=current_user.id, **data.model_dump())
    db.add(task)
    db.commit()
    db.refresh(task)
    return task


@app.put("/tasks/{task_id}", response_model=TaskRead)
def update_task(task_id: int, data: TaskUpdate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)) -> Task:
    task = db.query(Task).filter(Task.id == task_id, Task.user_id == current_user.id).first()
    if task is None:
        raise HTTPException(status_code=404, detail="Aufgabe nicht gefunden")
    for key, value in data.model_dump(exclude_unset=True).items():
        setattr(task, key, value)
    db.commit()
    db.refresh(task)
    return task


@app.delete("/tasks/{task_id}", status_code=204)
def delete_task(task_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)) -> None:
    task = db.query(Task).filter(Task.id == task_id, Task.user_id == current_user.id).first()
    if task is None:
        raise HTTPException(status_code=404, detail="Aufgabe nicht gefunden")
    db.delete(task)
    db.commit()
    return None


@app.get("/sessions", response_model=list[SessionRead])
def list_sessions(current_user: User = Depends(get_current_user), db: Session = Depends(get_db)) -> list[PomodoroSession]:
    return db.query(PomodoroSession).filter(PomodoroSession.user_id == current_user.id).order_by(PomodoroSession.ended_at.desc()).all()


@app.post("/sessions", response_model=SessionRead, status_code=201)
def create_session(
    data: SessionCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> PomodoroSession:
    existing = (
        db.query(PomodoroSession)
        .filter(
            PomodoroSession.user_id == current_user.id,
            PomodoroSession.client_session_id == data.client_session_id,
        )
        .first()
    )

    if existing is not None:
        return existing

    if data.task_id is not None:
        task = (
            db.query(Task)
            .filter(Task.id == data.task_id, Task.user_id == current_user.id)
            .first()
        )

        if task is None:
            raise HTTPException(status_code=404, detail="Aufgabe nicht gefunden")

    try:
        session = PomodoroSession(user_id=current_user.id, **data.model_dump())
        db.add(session)
        db.commit()
        db.refresh(session)
        return session
    except IntegrityError:
        db.rollback()

        existing = (
            db.query(PomodoroSession)
            .filter(
                PomodoroSession.user_id == current_user.id,
                PomodoroSession.client_session_id == data.client_session_id,
            )
            .first()
        )

        if existing is not None:
            return existing

        raise


def _user_sessions(db: Session, user_id: int) -> list[PomodoroSession]:
    return db.query(PomodoroSession).filter(PomodoroSession.user_id == user_id).all()


@app.get("/stats/daily", response_model=StatsResponse)
def stats_daily(
    tz: str = "Europe/Berlin",
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> StatsResponse:
    return build_stats(_user_sessions(db, current_user.id), "daily", tz)


@app.get("/stats/weekly", response_model=StatsResponse)
def stats_weekly(
    tz: str = "Europe/Berlin",
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> StatsResponse:
    return build_stats(_user_sessions(db, current_user.id), "weekly", tz)


@app.get("/stats/monthly", response_model=StatsResponse)
def stats_monthly(
    tz: str = "Europe/Berlin",
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> StatsResponse:
    return build_stats(_user_sessions(db, current_user.id), "monthly", tz)

@app.get("/stats/tasks", response_model=TaskStatsResponse)
def stats_tasks(current_user: User = Depends(get_current_user), db: Session = Depends(get_db)) -> TaskStatsResponse:
    return build_task_stats(_user_sessions(db, current_user.id))

@app.get("/settings", response_model=SettingsRead)
def get_settings(current_user: User = Depends(get_current_user), db: Session = Depends(get_db)) -> Setting:
    return _get_or_create_settings(db, current_user.id)


@app.put("/settings", response_model=SettingsRead)
def update_settings(data: SettingsBase, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)) -> Setting:
    settings = _get_or_create_settings(db, current_user.id)
    for key, value in data.model_dump().items():
        setattr(settings, key, value)
    db.commit()
    db.refresh(settings)
    return settings
