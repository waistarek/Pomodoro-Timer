"""add client session id to pomodoro sessions

Revision ID: <deine_revision_id>
Revises: <deine_vorherige_revision_id>
Create Date: <datum>
"""

from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


revision: str = "820492f2830d"
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # 1. Spalte zuerst nullable=True hinzufügen,
    # damit bestehende Zeilen nicht sofort gegen NOT NULL verstoßen.
    op.add_column(
        "pomodoro_sessions",
        sa.Column("client_session_id", sa.String(length=64), nullable=True),
    )

    # 2. Bestandsdaten eindeutig befüllen.
    # PostgreSQL: 'legacy-' || id::text
    op.execute(
        """
        UPDATE pomodoro_sessions
        SET client_session_id = 'legacy-' || id::text
        WHERE client_session_id IS NULL
        """
    )

    # 3. Danach NOT NULL setzen.
    op.alter_column(
        "pomodoro_sessions",
        "client_session_id",
        existing_type=sa.String(length=64),
        nullable=False,
    )

    # 4. Eindeutigkeit pro Benutzer erzwingen.
    op.create_unique_constraint(
        "uq_user_client_session",
        "pomodoro_sessions",
        ["user_id", "client_session_id"],
    )


def downgrade() -> None:
    # Achtung: Downgrade entfernt Idempotenz-Schutz.
    op.drop_constraint(
        "uq_user_client_session",
        "pomodoro_sessions",
        type_="unique",
    )

    op.drop_column("pomodoro_sessions", "client_session_id")