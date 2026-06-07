"""add app locale to settings

Revision ID: add_app_locale_to_settings
Revises: add_auth_identities
Create Date: 2026-06-07

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


revision: str = "add_app_locale_to_settings"
down_revision: Union[str, Sequence[str], None] = "add_auth_identities"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column(
        "settings",
        sa.Column(
            "app_locale",
            sa.String(length=20),
            nullable=False,
            server_default="system",
        ),
    )


def downgrade() -> None:
    op.drop_column("settings", "app_locale")