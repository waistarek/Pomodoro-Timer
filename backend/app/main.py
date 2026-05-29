import os
from fastapi import Depends, FastAPI, HTTPException, Query, status
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from .deps import get_current_user
from sqlalchemy import func
from .models import PomodoroSession, Setting, Task, User
from sqlalchemy.exc import IntegrityError
from datetime import date, datetime, timedelta
from fastapi import BackgroundTasks
from fastapi.responses import RedirectResponse
from .email_service import send_password_reset_email, send_verification_email
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
    PasswordResetConfirm,
    PasswordResetRequest,
    UserCreate,
    UserLogin,
    UserRead,
    TaskStatsResponse,
)
from .security import (
    create_access_token,
    create_email_verification_token,
    create_password_reset_token,
    hash_email_verification_token,
    hash_password,
    hash_password_reset_token,
    verify_password,
)
from .stats import build_month_stats, build_task_stats, build_week_stats, build_year_stats

from .database import get_db

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
def register(
    data: UserCreate,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
) -> User:
    existing = db.query(User).filter(User.email == data.email.lower()).first()
    if existing:
        raise HTTPException(status_code=409, detail="E-Mail ist bereits registriert")

    verification_token = create_email_verification_token()
    verification_token_hash = hash_email_verification_token(verification_token)

    user = User(
        email=data.email.lower(),
        password_hash=hash_password(data.password),
        is_email_verified=False,
        email_verification_token_hash=verification_token_hash,
        email_verification_expires_at=datetime.utcnow() + timedelta(hours=24),
    )

    db.add(user)
    db.commit()
    db.refresh(user)

    _get_or_create_settings(db, user.id)

    background_tasks.add_task(send_verification_email, user.email, verification_token)

    return user


@app.post("/auth/login", response_model=Token)
def login(data: UserLogin, db: Session = Depends(get_db)) -> Token:
    user = db.query(User).filter(User.email == data.email.lower()).first()
    if user is None or not verify_password(data.password, user.password_hash):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Falsche E-Mail oder falsches Passwort")

    if not user.is_email_verified:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Bitte bestätige zuerst deine E-Mail-Adresse.",
        )

    return Token(
        access_token=create_access_token(
            str(user.id),
            user.auth_version,
        )
    )

@app.post("/auth/request-password-reset", status_code=202)
def request_password_reset(
    data: PasswordResetRequest,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
) -> dict[str, str]:
    user = db.query(User).filter(User.email == data.email.lower()).first()

    response = {
        "message": (
            "Falls ein Konto mit dieser E-Mail existiert, wurde ein Link "
            "zum Zurücksetzen des Passworts versendet."
        )
    }

    if user is None:
        return response

    reset_token = create_password_reset_token()
    reset_token_hash = hash_password_reset_token(reset_token)

    user.password_reset_token_hash = reset_token_hash
    user.password_reset_expires_at = datetime.utcnow() + timedelta(minutes=60)

    db.commit()

    background_tasks.add_task(
        send_password_reset_email,
        user.email,
        reset_token,
    )

    return response


@app.post("/auth/reset-password")
def reset_password(
    data: PasswordResetConfirm,
    db: Session = Depends(get_db),
) -> dict[str, str]:
    token_hash = hash_password_reset_token(data.token)

    user = (
        db.query(User)
        .filter(User.password_reset_token_hash == token_hash)
        .first()
    )

    if user is None:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Der Link zum Zurücksetzen des Passworts ist ungültig.",
        )

    if user.password_reset_expires_at is None:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Der Link zum Zurücksetzen des Passworts ist ungültig.",
        )

    if user.password_reset_expires_at < datetime.utcnow():
        user.password_reset_token_hash = None
        user.password_reset_expires_at = None
        db.commit()

        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Der Link zum Zurücksetzen des Passworts ist abgelaufen.",
        )

    user.password_hash = hash_password(data.new_password)
    user.password_reset_token_hash = None
    user.password_reset_expires_at = None

    # Der Reset-Link beweist Zugriff auf die E-Mail-Adresse.
    user.is_email_verified = True

    # Alle alten Login-Tokens sofort ungültig machen.
    user.auth_version += 1

    db.commit()

    return {"message": "Passwort wurde erfolgreich zurückgesetzt."}

@app.get("/auth/verify-email")
def verify_email(token: str, db: Session = Depends(get_db)):
    token_hash = hash_email_verification_token(token)

    user = (
        db.query(User)
        .filter(User.email_verification_token_hash == token_hash)
        .first()
    )

    frontend_url = os.getenv("FRONTEND_URL", "https://pomodoro-wise.netlify.app").rstrip("/")

    if user is None:
        return RedirectResponse(
            f"{frontend_url}/?screen=login&email_verified=invalid"
        )
    if user.email_verification_expires_at is None:
        return RedirectResponse(
            f"{frontend_url}/?screen=login&email_verified=invalid"
        )

    if user.email_verification_expires_at < datetime.utcnow():
        return RedirectResponse(
            f"{frontend_url}/?screen=login&email_verified=expired"
        )

    user.is_email_verified = True
    user.email_verification_token_hash = None
    user.email_verification_expires_at = None

    db.commit()

    return RedirectResponse(
        f"{frontend_url}/?screen=login&email_verified=success"
    )

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


@app.get("/stats/week", response_model=StatsResponse)
def stats_week(
    reference_date: date | None = Query(default=None, alias="date"),
    tz: str = "Europe/Berlin",
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> StatsResponse:
    return build_week_stats(
        _user_sessions(db, current_user.id),
        reference_date,
        tz,
    )


@app.get("/stats/month", response_model=StatsResponse)
def stats_month(
    year: int | None = Query(default=None, ge=1970, le=2100),
    month: int | None = Query(default=None, ge=1, le=12),
    tz: str = "Europe/Berlin",
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> StatsResponse:
    return build_month_stats(
        _user_sessions(db, current_user.id),
        year,
        month,
        tz,
    )


@app.get("/stats/year", response_model=StatsResponse)
def stats_year(
    year: int | None = Query(default=None, ge=1970, le=2100),
    tz: str = "Europe/Berlin",
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> StatsResponse:
    return build_year_stats(
        _user_sessions(db, current_user.id),
        year,
        tz,
    )


@app.get("/stats/tasks", response_model=TaskStatsResponse)
def stats_tasks(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> TaskStatsResponse:
    return build_task_stats(_user_sessions(db, current_user.id))


# Alte Endpunkte bleiben für Tests und alte Frontend-Versionen kompatibel.
@app.get("/stats/daily", response_model=StatsResponse)
def stats_daily(
    tz: str = "Europe/Berlin",
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> StatsResponse:
    return build_week_stats(
        _user_sessions(db, current_user.id),
        None,
        tz,
    )


@app.get("/stats/weekly", response_model=StatsResponse)
def stats_weekly(
    tz: str = "Europe/Berlin",
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> StatsResponse:
    return build_month_stats(
        _user_sessions(db, current_user.id),
        None,
        None,
        tz,
    )


@app.get("/stats/monthly", response_model=StatsResponse)
def stats_monthly(
    tz: str = "Europe/Berlin",
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
) -> StatsResponse:
    return build_year_stats(
        _user_sessions(db, current_user.id),
        None,
        tz,
    )



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
