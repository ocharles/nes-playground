CREATE SEQUENCE revision_id_offset MINVALUE 0 START WITH 0;
SELECT setval('revision_id_offset', 0);

CREATE FUNCTION partial_date(year INT, month INT, day INT)
RETURNS partial_date AS $$
  DECLARE
    ret partial_date;
  BEGIN
    IF year IS NULL AND month IS NULL AND day IS NULL
    THEN ret := NULL;
    ELSE ret := row(year, month, day);
    END IF;
    RETURN ret;
  END;
$$ LANGUAGE 'plpgsql' IMMUTABLE;

INSERT INTO editor (editor_id, name, password) VALUES (4, 'ModBot', 'password');

INSERT INTO artist_name (id, name) SELECT id, name FROM musicbrainz.artist_name;
INSERT INTO label_name (id, name) SELECT id, name FROM musicbrainz.label_name;
INSERT INTO release_name (id, name) SELECT id, name FROM musicbrainz.release_name;
INSERT INTO track_name (id, name) SELECT id, name FROM musicbrainz.track_name;
INSERT INTO work_name (id, name) SELECT id, name FROM musicbrainz.work_name;

INSERT INTO release_status (id, name) SELECT id, name FROM musicbrainz.release_status;
INSERT INTO release_packaging (id, name) SELECT id, name FROM musicbrainz.release_packaging;
INSERT INTO country (id, iso_code, name) SELECT id, iso_code, name FROM musicbrainz.country;
INSERT INTO language (id, name, iso_code_2t, iso_code_2b, iso_code_1, frequency, iso_code_3)
SELECT id, name, iso_code_2t, iso_code_2b, iso_code_1, frequency, iso_code_3 FROM musicbrainz.language;
INSERT INTO script (id, name, iso_code, iso_number)
SELECT id, name, iso_code, iso_number FROM musicbrainz.script;

INSERT INTO artist_alias_type SELECT * FROM musicbrainz.artist_alias_type;
INSERT INTO artist_type SELECT * FROM musicbrainz.artist_type;
INSERT INTO gender SELECT * FROM musicbrainz.gender;
INSERT INTO label_alias_type SELECT * FROM musicbrainz.label_alias_type;
INSERT INTO label_type SELECT * FROM musicbrainz.label_type;
INSERT INTO medium_format SELECT * FROM musicbrainz.medium_format;
INSERT INTO clientversion SELECT * FROM musicbrainz.clientversion;
INSERT INTO puid (id, puid, version) SELECT id, puid::uuid, version FROM musicbrainz.puid;

INSERT INTO release_group_primary_type (id, name) SELECT id, name FROM musicbrainz.release_group_primary_type;
INSERT INTO release_group_secondary_type (id, name) SELECT id, name FROM musicbrainz.release_group_secondary_type;

\i migrate/migrate-artist.sql
\i migrate/migrate-label.sql
\i migrate/migrate-recording.sql
\i migrate/migrate-release.sql
\i migrate/migrate-release-group.sql
\i migrate/migrate-work.sql
\i migrate/migrate-url.sql

DROP SEQUENCE revision_id_offset;
