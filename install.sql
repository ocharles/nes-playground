\set ON_ERROR_STOP 0
CREATE USER musicbrainz;

\set ON_ERROR_STOP 1

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;

DROP SCHEMA IF EXISTS musicbrainz CASCADE;
CREATE SCHEMA musicbrainz AUTHORIZATION musicbrainz;

ALTER USER musicbrainz SET search_path TO musicbrainz, public;

SET search_path = musicbrainz, public;
\i sql/core/Types.sql
\i sql/core/Tables.sql
\i sql/core/Keys.sql
\i sql/editor/Tables.sql
\i sql/editor/Keys.sql
\i sql/core/ForeignKeys.sql
