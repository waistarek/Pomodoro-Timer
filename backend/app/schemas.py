from datetime import datetime
from pydantic import BaseModel, ConfigDict, EmailStr, Field


class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"


class UserCreate(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8)


class UserLogin(BaseModel):
    email: EmailStr
    password: str

    
class PasswordResetRequest(BaseModel):
    email: EmailStr


class PasswordResetConfirm(BaseModel):
    token: str = Field(min_length=20)
    new_password: str = Field(min_length=8)


class UserRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    email: EmailStr
    created_at: datetime
    is_email_verified: bool


class TaskBase(BaseModel):
    title: str = Field(min_length=1, max_length=255)
    description: str = ""
    priority: str = "medium"
    tags: str = ""
    completed: bool = False


class TaskCreate(TaskBase):
    pass


class TaskUpdate(BaseModel):
    title: str | None = None
    description: str | None = None
    priority: str | None = None
    tags: str | None = None
    completed: bool | None = None


class TaskRead(TaskBase):
    model_config = ConfigDict(from_attributes=True)

    id: int
    user_id: int
    created_at: datetime
    completed_pomodoros: int = 0


class SessionCreate(BaseModel):
    client_session_id: str = Field(min_length=1, max_length=64)
    task_id: int | None = None
    phase_type: str
    duration_minutes: int = Field(gt=0)
    completed: bool = True
    started_at: datetime
    ended_at: datetime


class SessionRead(SessionCreate):
    model_config = ConfigDict(from_attributes=True)

    id: int
    user_id: int


class SettingsBase(BaseModel):
    work_minutes: int = Field(default=25, ge=1, le=180)
    short_break_minutes: int = Field(default=5, ge=1, le=120)
    long_break_minutes: int = Field(default=15, ge=1, le=180)
    long_break_after: int = Field(default=4, ge=1, le=20)
    auto_start: bool = False
    sound_enabled: bool = True
    vibration_enabled: bool = True
    theme: str = "system"
    color_name: str = "red"


class SettingsRead(SettingsBase):
    model_config = ConfigDict(from_attributes=True)

    id: int
    user_id: int


class StatsItem(BaseModel):
    label: str
    pomodoros: int
    focus_minutes: int
    completed_sessions: int
    total_sessions: int
    success_rate: float


class StatsResponse(BaseModel):
    items: list[StatsItem]
    total_pomodoros: int
    total_focus_minutes: int
    current_streak_days: int
    best_focus_day: str | None = None
    period_start: str | None = None
    period_end: str | None = None
    period_label: str | None = None

class TaskStatsItem(BaseModel):
    task_id: int | None = None
    task_title: str
    pomodoros: int
    focus_minutes: int
    focus_hours: float


class TaskStatsResponse(BaseModel):
    items: list[TaskStatsItem]
    total_pomodoros: int
    total_focus_minutes: int
