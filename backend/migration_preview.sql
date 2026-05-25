BEGIN;

CREATE TABLE alembic_version (
    version_num VARCHAR(32) NOT NULL, 
    CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);

-- Running upgrade  -> 820492f2830d

ALTER TABLE pomodoro_sessions ADD COLUMN client_session_id VARCHAR(64);

UPDATE pomodoro_sessions
        SET client_session_id = 'legacy-' || id::text
        WHERE client_session_id IS NULL;

ALTER TABLE pomodoro_sessions ALTER COLUMN client_session_id SET NOT NULL;

ALTER TABLE pomodoro_sessions ADD CONSTRAINT uq_user_client_session UNIQUE (user_id, client_session_id);

INSERT INTO alembic_version (version_num) VALUES ('820492f2830d') RETURNING alembic_version.version_num;

COMMIT;

