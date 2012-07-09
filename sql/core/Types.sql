BEGIN;

CREATE TYPE partial_date AS (
  year SMALLINT,
  month SMALLINT,
  day SMALLINT
);

CREATE DOMAIN comment AS TEXT;

CREATE DOMAIN ipi AS CHAR(11)
CHECK (VALUE ~ E'^\\d{11}$');

CREATE DOMAIN rating AS SMALLINT
CHECK (VALUE BETWEEN 0 AND 100);

CREATE DOMAIN natural_integer AS INTEGER
CHECK (VALUE >= 0);

CREATE DOMAIN positive_integer AS INTEGER
CHECK (VALUE > 0);

CREATE DOMAIN single_line AS TEXT;
-- CHECK (VALUE !~ E'[\\n\\r]');

CREATE DOMAIN presentational_text AS single_line;
-- CHECK (
--     VALUE ~ E'^[[:print:]]+$'
--       AND VALUE !~ E'\\s{2,}'
--       AND VALUE = btrim(inp);
-- );

CREATE DOMAIN non_empty_presentational_text AS presentational_text;
-- CHECK (VALUE ~ E'.+');

CREATE DOMAIN locale AS varchar(30)
CHECK (VALUE ~ E'^[a-zA-Z_]+$');

CREATE DOMAIN isrc_t AS char(12)
CHECK (VALUE ~ E'^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');

CREATE DOMAIN iswc_t AS char(15)
CHECK (VALUE ~ E'^T-?\\d{3}.?\\d{3}.?\\d{3}[-.]?\\d$');

CREATE DOMAIN label_code AS integer
CHECK (VALUE > 0 AND VALUE < 100000);

CREATE TYPE relationship_endpoint AS enum
('artist', 'label', 'recording', 'release', 'release_group', 'url', 'work');

CREATE TYPE cover_art_presence AS ENUM ('absent', 'present', 'darkened');

COMMIT;
