BEGIN;

DROP SCHEMA IF EXISTS nes_api CASCADE;
CREATE SCHEMA nes_api;

SET search_path = nes_api, nes_playground, public;

\i api/Artist.sql
\i api/ReleaseGroup.sql

GRANT ALL ON SCHEMA nes_api TO musicbrainz;
GRANT ALL ON SCHEMA nes_playground TO musicbrainz;
GRANT ALL ON ALL TABLES IN SCHEMA nes_playground TO musicbrainz;

COMMIT;
