import calendar
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


def _streak_days(
    sessions: list[PomodoroSession],
    tz: str = DEFAULT_TIMEZONE,
) -> int:
    work_days = {
        _local_date(session.ended_at, tz)
        for session in sessions
        if session.completed and session.phase_type == "work"
    }

    streak = 0
    day = _today(tz)

    while day in work_days:
        streak += 1
        day -= timedelta(days=1)

    return streak


def _build_stats_response(
    sessions: list[PomodoroSession],
    labels: list[date],
    label_for_date,
    key_for_session,
    period_start: date,
    period_end: date,
    period_label: str,
    tz: str = DEFAULT_TIMEZONE,
) -> StatsResponse:
    buckets: dict[str, list[PomodoroSession]] = defaultdict(list)

    for session in sessions:
        session_date = _local_date(session.ended_at, tz)

        if session_date < period_start or session_date > period_end:
            continue

        key = key_for_session(session_date)
        buckets[key].append(session)

    items: list[StatsItem] = []

    for item_date in labels:
        key = label_for_date(item_date)
        bucket = buckets.get(key, [])

        total_sessions = len(bucket)
        completed_sessions = sum(1 for session in bucket if session.completed)

        work_sessions = [
            session
            for session in bucket
            if session.completed and session.phase_type == "work"
        ]

        focus_minutes = sum(session.duration_minutes for session in work_sessions)
        pomodoros = len(work_sessions)

        success_rate = (
            round((completed_sessions / total_sessions) * 100, 2)
            if total_sessions
            else 0.0
        )

        items.append(
            StatsItem(
                label=key,
                pomodoros=pomodoros,
                focus_minutes=focus_minutes,
                completed_sessions=completed_sessions,
                total_sessions=total_sessions,
                success_rate=success_rate,
            )
        )

    best = max(items, key=lambda item: item.focus_minutes, default=None)

    return StatsResponse(
        items=items,
        total_pomodoros=sum(item.pomodoros for item in items),
        total_focus_minutes=sum(item.focus_minutes for item in items),
        current_streak_days=_streak_days(sessions, tz),
        best_focus_day=best.label if best and best.focus_minutes > 0 else None,
        period_start=period_start.isoformat(),
        period_end=period_end.isoformat(),
        period_label=period_label,
    )


def build_week_stats(
    sessions: list[PomodoroSession],
    reference_date: date | None = None,
    tz: str = DEFAULT_TIMEZONE,
) -> StatsResponse:
    selected_date = reference_date or _today(tz)

    monday = selected_date - timedelta(days=selected_date.weekday())
    sunday = monday + timedelta(days=6)

    labels = [monday + timedelta(days=index) for index in range(7)]
    iso = monday.isocalendar()

    return _build_stats_response(
        sessions=sessions,
        labels=labels,
        label_for_date=lambda item_date: item_date.isoformat(),
        key_for_session=lambda session_date: session_date.isoformat(),
        period_start=monday,
        period_end=sunday,
        period_label=f"KW {iso.week:02d} / {iso.year}",
        tz=tz,
    )


def _month_week_labels(start: date, end: date) -> list[date]:
    labels = [start]

    days_until_next_monday = (7 - start.weekday()) % 7
    next_monday = start + timedelta(days=days_until_next_monday)

    if next_monday == start:
        next_monday += timedelta(days=7)

    current = next_monday

    while current <= end:
        labels.append(current)
        current += timedelta(days=7)

    return labels


def _iso_week_key(item_date: date) -> str:
    iso = item_date.isocalendar()

    return f"{iso.year}-W{iso.week:02d}"


def build_month_stats(
    sessions: list[PomodoroSession],
    year: int | None = None,
    month: int | None = None,
    tz: str = DEFAULT_TIMEZONE,
) -> StatsResponse:
    today = _today(tz)

    selected_year = year if year is not None else today.year
    selected_month = month if month is not None else today.month

    last_day = calendar.monthrange(selected_year, selected_month)[1]

    start = date(selected_year, selected_month, 1)
    end = date(selected_year, selected_month, last_day)

    labels = _month_week_labels(start, end)

    return _build_stats_response(
        sessions=sessions,
        labels=labels,
        label_for_date=_iso_week_key,
        key_for_session=_iso_week_key,
        period_start=start,
        period_end=end,
        period_label=f"{selected_month:02d}.{selected_year}",
        tz=tz,
    )


def build_year_stats(
    sessions: list[PomodoroSession],
    year: int | None = None,
    tz: str = DEFAULT_TIMEZONE,
) -> StatsResponse:
    today = _today(tz)
    selected_year = year if year is not None else today.year

    start = date(selected_year, 1, 1)
    end = date(selected_year, 12, 31)

    labels = [date(selected_year, month, 1) for month in range(1, 13)]

    return _build_stats_response(
        sessions=sessions,
        labels=labels,
        label_for_date=lambda item_date: f"{item_date.year}-{item_date.month:02d}",
        key_for_session=lambda session_date: f"{session_date.year}-{session_date.month:02d}",
        period_start=start,
        period_end=end,
        period_label=str(selected_year),
        tz=tz,
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
        buckets[task_id]["focus_minutes"] = (
            int(buckets[task_id]["focus_minutes"]) + session.duration_minutes
        )

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