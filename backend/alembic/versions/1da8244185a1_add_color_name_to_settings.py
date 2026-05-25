"""add color name to settings

Revision ID: 1da8244185a1
Revises: 820492f2830d
Create Date: 2026-05-25 18:32:47.394424

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '1da8244185a1'
down_revision: Union[str, Sequence[str], None] = '820492f2830d'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column(
        "settings",
        sa.Column(
            "color_name",
            sa.String(length=50),
            nullable=False,
            server_default="red",
        ),
    )

    op.execute(
        """
        UPDATE settings
        SET color_name = 'red'
        WHERE color_name IS NULL
        """
    )


def downgrade() -> None:
    op.drop_column("settings", "color_name")
