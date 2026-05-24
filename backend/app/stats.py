from collections import defaultdict
from datetime import date, datetime, timedelta, timezone 
from zoneinfo import ZoneInfo 
from .models import PomodoroSession
from .schemas import StatsItem, StatsResponse, TaskStatsItem, TaskStatsResponse


DEFAULT_TIMEZONE = "Europe/Berlin"


def _as_utc(dt: datetime) -> datetime:
    if dt.tzinfo is None:
        return dt.replace(tzinfo=timezone.utc)
    return dt.astimezone(timezone.utc)


def _local_date(dt: datetime, tz: str = DEFAULT_TIMEZONE) -> date:
    return _as_utc(dt).astimezone(ZoneInfo(tz)).date()


def _today(tz: str = DEFAULT_TIMEZONE) -> date:
    return datetime.now(timezone.utc).astimezone(ZoneInfo(tz)).date()

def _date_range(days: int, tz: str = DEFAULT_TIMEZONE) -> list[date]:
    today = _today(tz)
    start = today - timedelta(days=days - 1)
    return [start + timedelta(days=i) for i in range(days)]


def _streak_days(
    sessions: list[PomodoroSession],
    tz: str = DEFAULT_TIMEZONE,
) -> int:
    work_days = {
        _local_date(s.ended_at, tz)
        for s in sessions
        if s.completed and s.phase_type == "work"
    }

    streak = 0
    day = _today(tz)

    while day in work_days:
        streak += 1
        day -= timedelta(days=1)

    return streak


def build_stats(
    sessions: list[PomodoroSession],
    mode: str,
    tz: str = DEFAULT_TIMEZONE,
) -> StatsResponse:
    if mode == "daily":
        labels = _date_range(14, tz)
        label_for = lambda d: d.isoformat()
    elif mode == "weekly":
        labels = []
        today = _today(tz)
        monday = today - timedelta(days=today.weekday())
        for i in range(7, -1, -1):
            labels.append(monday - timedelta(weeks=i))
        label_for = lambda d: f"{d.isocalendar().year}-KW{d.isocalendar().week:02d}"
    else:
        labels = []
        today = _today(tz).replace(day=1)
        for i in range(11, -1, -1):
            year = today.year
            month = today.month - i
            while month <= 0:
                month += 12
                year -= 1
            labels.append(date(year, month, 1))
        label_for = lambda d: f"{d.year}-{d.month:02d}"

    buckets: dict[str, list[PomodoroSession]] = defaultdict(list)
    for session in sessions:
        ended = _local_date(session.ended_at, tz)
        if mode == "daily":
            key = ended.isoformat()
        elif mode == "weekly":
            key = f"{ended.isocalendar().year}-KW{ended.isocalendar().week:02d}"
        else:
            key = f"{ended.year}-{ended.month:02d}"
        buckets[key].append(session)

    items: list[StatsItem] = []
    for item_date in labels:
        key = label_for(item_date)
        bucket = buckets.get(key, [])
        total = len(bucket)
        completed = sum(1 for s in bucket if s.completed)
        work_sessions = [s for s in bucket if s.completed and s.phase_type == "work"]
        focus_minutes = sum(s.duration_minutes for s in work_sessions)
        pomodoros = len(work_sessions)
        success_rate = round((completed / total) * 100, 2) if total else 0.0
        items.append(
            StatsItem(
                label=key,
                pomodoros=pomodoros,
                focus_minutes=focus_minutes,
                completed_sessions=completed,
                total_sessions=total,
                success_rate=success_rate,
            )
        )

    best = max(items, key=lambda x: x.focus_minutes, default=None)
    return StatsResponse(
        items=items,
        total_pomodoros=sum(i.pomodoros for i in items),
        total_focus_minutes=sum(i.focus_minutes for i in items),
        current_streak_days=_streak_days(sessions, tz),
        best_focus_day=best.label if best and best.focus_minutes > 0 else None,
    )

def build_task_stats(sessions: list[PomodoroSession]) -> TaskStatsResponse:
    buckets: dict[int | None, dict[str, int | str | None]] = {}

    for session in sessions:
        if not session.completed or session.phase_type != "work":
            continue

        task_id = session.task_id
        task_title = session.task.title if session.task is not None else "Ohne Aufgabe"

        if task_id not in buckets:
            buckets[task_id] = {
                "task_id": task_id,
                "task_title": task_title,
                "pomodoros": 0,
                "focus_minutes": 0,
            }

        buckets[task_id]["pomodoros"] = int(buckets[task_id]["pomodoros"]) + 1
        buckets[task_id]["focus_minutes"] = int(buckets[task_id]["focus_minutes"]) + session.duration_minutes

    items = [
        TaskStatsItem(
            task_id=data["task_id"],
            task_title=str(data["task_title"]),
            pomodoros=int(data["pomodoros"]),
            focus_minutes=int(data["focus_minutes"]),
            focus_hours=round(int(data["focus_minutes"]) / 60, 2),
        )
        for data in buckets.values()
    ]

    items.sort(key=lambda item: item.focus_minutes, reverse=True)

    return TaskStatsResponse(
        items=items,
        total_pomodoros=sum(item.pomodoros for item in items),
        total_focus_minutes=sum(item.focus_minutes for item in items),
    )