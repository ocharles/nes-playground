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

COMMIT;
