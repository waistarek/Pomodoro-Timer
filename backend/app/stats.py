from collections import defaultdict
from datetime import date, datetime, timedelta
from .models import PomodoroSession
from .schemas import StatsItem, StatsResponse


def _date_range(days: int) -> list[date]:
    today = datetime.utcnow().date()
    start = today - timedelta(days=days - 1)
    return [start + timedelta(days=i) for i in range(days)]


def _streak_days(sessions: list[PomodoroSession]) -> int:
    work_days = {
        s.ended_at.date()
        for s in sessions
        if s.completed and s.phase_type == "work"
    }
    streak = 0
    day = datetime.utcnow().date()
    while day in work_days:
        streak += 1
        day -= timedelta(days=1)
    return streak


def build_stats(sessions: list[PomodoroSession], mode: str) -> StatsResponse:
    if mode == "daily":
        labels = _date_range(14)
        label_for = lambda d: d.isoformat()
    elif mode == "weekly":
        labels = []
        today = datetime.utcnow().date()
        monday = today - timedelta(days=today.weekday())
        for i in range(7, -1, -1):
            labels.append(monday - timedelta(weeks=i))
        label_for = lambda d: f"{d.isocalendar().year}-KW{d.isocalendar().week:02d}"
    else:
        labels = []
        today = datetime.utcnow().date().replace(day=1)
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
        ended = session.ended_at.date()
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
        current_streak_days=_streak_days(sessions),
        best_focus_day=best.label if best and best.focus_minutes > 0 else None,
    )
