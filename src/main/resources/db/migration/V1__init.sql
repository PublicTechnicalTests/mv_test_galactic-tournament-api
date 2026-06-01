-- Initial Flyway migration for Galactic Tournament API
-- This migration initializes the database baseline in a reproducible way.

CREATE SCHEMA IF NOT EXISTS galactic_tournament;

CREATE TABLE IF NOT EXISTS galactic_tournament.bootstrap_marker (
    id SMALLINT PRIMARY KEY,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO galactic_tournament.bootstrap_marker (id)
VALUES (1)
ON CONFLICT (id) DO NOTHING;

