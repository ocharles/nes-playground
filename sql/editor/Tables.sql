BEGIN;

CREATE TABLE editor
(
    editor_id serial,
    name varchar(64) NOT NULL,
    password varchar(64) NOT NULL,
    privs integer DEFAULT 0,
    email varchar(64) DEFAULT NULL,
    website varchar(255) DEFAULT NULL,
    bio text DEFAULT NULL,
    member_since timestamp WITH TIME ZONE DEFAULT NOW(),
    email_confirm_date timestamp WITH TIME ZONE,
    last_login_date timestamp WITH TIME ZONE,
    last_updated timestamp WITH TIME ZONE DEFAULT NOW(),
    birth_date date,
    gender_id integer,
    country_id integer
);

CREATE TABLE artist_rating_raw (
    artist_id uuid NOT NULL,
    rating rating NOT NULL,
    editor_id integer NOT NULL
);

CREATE TABLE artist_tag_raw (
    artist_id uuid NOT NULL,
    tag_id integer NOT NULL,
    editor_id integer NOT NULL
);

CREATE TABLE label_rating_raw (
    label_id uuid NOT NULL,
    rating rating NOT NULL,
    editor_id integer NOT NULL
);

CREATE TABLE label_tag_raw (
    label_id uuid NOT NULL,
    tag_id integer NOT NULL,
    editor_id integer NOT NULL
);

CREATE TABLE recording_rating_raw (
    recording_id uuid NOT NULL,
    rating rating NOT NULL,
    editor_id integer NOT NULL
);

CREATE TABLE recording_tag_raw (
    recording_id uuid NOT NULL,
    tag_id integer NOT NULL,
    editor_id integer NOT NULL
);

CREATE TABLE release_group_rating_raw (
    release_group_id uuid NOT NULL,
    rating rating NOT NULL,
    editor_id integer NOT NULL
);

CREATE TABLE release_group_tag_raw (
    release_group_id uuid NOT NULL,
    tag_id integer NOT NULL,
    editor_id integer NOT NULL
);

CREATE TABLE release_tag_raw (
    release_id uuid NOT NULL,
    tag_id integer NOT NULL,
    editor_id integer NOT NULL
);

CREATE TABLE work_rating_raw (
    work_id uuid NOT NULL,
    rating rating NOT NULL,
    editor_id integer NOT NULL
);

CREATE TABLE work_tag_raw (
    work_id uuid NOT NULL,
    tag_id integer NOT NULL,
    editor_id integer NOT NULL
);

COMMIT;
