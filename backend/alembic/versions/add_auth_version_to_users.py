"""add auth version to users

Revision ID: add_auth_version_to_users
Revises: 9b1c0d2e3f4a
Create Date: 2026-05-28

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


revision: str = "add_auth_version_to_users"
down_revision: Union[str, Sequence[str], None] = "9b1c0d2e3f4a"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column(
        "users",
        sa.Column(
            "auth_version",
            sa.Integer(),
            nullable=False,
            server_default="0",
        ),
    )

    op.alter_column(
        "users",
        "auth_version",
        server_default=None,
    )


def downgrade() -> None:
    op.drop_column("users", "auth_version")