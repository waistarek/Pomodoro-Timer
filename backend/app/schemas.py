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


class UserRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    email: EmailStr
    created_at: datetime


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


class SessionCreate(BaseModel):
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
