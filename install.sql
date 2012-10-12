\set ON_ERROR_STOP 0
CREATE USER musicbrainz;

\set ON_ERROR_STOP 1

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;

DROP SCHEMA IF EXISTS musicbrainz CASCADE;
CREATE SCHEMA musicbrainz AUTHORIZATION musicbrainz;

ALTER USER musicbrainz SET search_path TO musicbrainz, public;

SET search_path = musicbrainz, public;
\ir sql/core/Types.sql
\ir sql/core/Tables.sql
\ir sql/core/Keys.sql
\ir sql/editor/Tables.sql
\ir sql/editor/Keys.sql
\ir sql/core/ForeignKeys.sql
