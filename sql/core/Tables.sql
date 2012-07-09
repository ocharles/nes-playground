BEGIN;

CREATE TABLE artist_revision (
    revision_id integer NOT NULL,
    artist_id uuid NOT NULL,
    artist_tree_id integer NOT NULL
);

CREATE TABLE artist (
    artist_id uuid NOT NULL,
    master_revision_id integer NOT NULL,
    merged_into uuid
);

CREATE TABLE artist_name (
    id serial NOT NULL,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE artist_data (
    artist_data_id serial NOT NULL,
    name integer NOT NULL,
    sort_name integer NOT NULL,
    begin_date partial_date,
    end_date partial_date,
    artist_type_id integer,
    country_id integer,
    gender_id integer,
    comment presentational_text NOT NULL DEFAULT '',
    ended boolean NOT NULL DEFAULT FALSE
);

CREATE TABLE artist_alias_type (
    id serial,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE artist_alias (
    artist_tree_id integer NOT NULL,
    name integer NOT NULL,
    sort_name integer NOT NULL,
    locale locale,
    artist_alias_type_id integer,
    begin_date partial_date,
    end_date partial_date,
    primary_for_locale boolean NOT NULL DEFAULT false
);

CREATE TABLE artist_tree (
    artist_tree_id integer NOT NULL,
    artist_data_id integer NOT NULL,
    annotation text
);

CREATE TABLE artist_ipi (
    artist_tree_id integer NOT NULL,
    ipi ipi NOT NULL
);

CREATE TABLE artist_meta (
    artist_id uuid NOT NULL,
    rating rating,
    rating_count natural_integer NOT NULL
);

CREATE TABLE artist_tag (
    artist_id uuid NULL,
    tag_id integer NOT NULL,
    count positive_integer NOT NULL
);

CREATE TABLE artist_credit (
    artist_credit_id serial
);

CREATE TABLE artist_credit_name (
    artist_credit_id integer NOT NULL,
    position natural_integer NOT NULL,
    artist_id uuid NOT NULL,
    name integer NOT NULL,
    join_phrase single_line NOT NULL DEFAULT ''
);

CREATE TABLE artist_type (
    id serial,
    name presentational_text NOT NULL
);

CREATE TABLE cdtoc (
    id serial,
    discid char(28) NOT NULL,
    freedb_id char(8) NOT NULL,
    track_count positive_integer NOT NULL,
    leadout_offset positive_integer NOT NULL,
    track_offset integer[] NOT NULL, -- TODO
    degraded boolean NOT NULL DEFAULT FALSE,
    created timestamp WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE clientversion
(
    id serial,
    version varchar(64) NOT NULL,
    created timestamp WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE country (
    id serial,
    iso_code varchar(2) NOT NULL,
    name varchar(255) NOT NULL
);

CREATE TABLE gender (
    id serial,
    name varchar(255) NOT NULL
);

CREATE TABLE isrc (
    id serial,
    recording_tree_id integer NOT NULL,
    isrc isrc_t NOT NULL,
    source smallint
);

CREATE TABLE iswc (
    id serial NOT NULL,
    work_tree_id integer NOT NULL,
    iswc iswc_t NOT NULL,
    source SMALLINT
);

CREATE TABLE label (
    label_id uuid NOT NULL,
    master_revision_id integer NOT NULL,
    merged_into uuid
);

CREATE TABLE label_data (
    label_data_id serial,
    name integer NOT NULL,
    sort_name integer NOT NULL,
    begin_date partial_date,
    end_date partial_date,
    label_type_id integer,
    label_code label_code,
    country_id integer,
    comment presentational_text,
    ended boolean NOT NULL DEFAULT FALSE
);

CREATE TABLE label_alias_type (
    id serial,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE label_alias (
    label_tree_id integer NOT NULL,
    name integer NOT NULL,
    sort_name integer NOT NULL,
    locale locale,
    label_alias_type_id integer,
    begin_date partial_date,
    end_date partial_date,
    primary_for_locale boolean NOT NULL DEFAULT false
);

CREATE TABLE label_ipi (
    label_tree_id integer NOT NULL,
    ipi ipi NOT NULL
);

CREATE TABLE label_meta (
    label_id uuid NOT NULL,
    rating rating,
    rating_count natural_integer NOT NULL
);

CREATE TABLE label_name (
    id serial,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE label_revision (
    revision_id integer NOT NULL,
    label_id uuid NOT NULL,
    label_tree_id integer NOT NULL
);

CREATE TABLE label_tag (
    label_id uuid NULL,
    tag_id integer NOT NULL,
    count positive_integer NOT NULL
);

CREATE TABLE label_tree (
    label_tree_id serial NOT NULL,
    label_data_id integer NOT NULL,
    annotation TEXT
);

CREATE TABLE label_type (
    id serial,
    name presentational_text NOT NULL
);

CREATE TABLE language (
    id serial,
    iso_code_2t char(3), -- ISO 639-2 (T)
    iso_code_2b char(3), -- ISO 639-2 (B)
    iso_code_1 char(2), -- ISO 639
    iso_code_3 char(3),  -- ISO 639-3
    name non_empty_presentational_text NOT NULL,
    frequency natural_integer NOT NULL DEFAULT 0
);

CREATE TABLE link (
    id serial,
    link_type integer NOT NULL,
    begin_date partial_date,
    end_date partial_date,
    attribute_count natural_integer NOT NULL DEFAULT 0,
    created timestamp WITH TIME ZONE DEFAULT NOW(),
    ended boolean NOT NULL DEFAULT FALSE
);

CREATE TABLE link_attribute (
    link integer NOT NULL,
    attribute_type integer NOT NULL,
    created timestamp WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE link_attribute_type (
    id serial,
    parent integer,
    root integer NOT NULL,
    child_order natural_integer NOT NULL DEFAULT 0,
    gid uuid NOT NULL,
    name varchar(255) NOT NULL,
    description text,
    last_updated timestamp WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE link_type (
    id serial,
    parent integer,
    child_order natural_integer NOT NULL DEFAULT 0,
    gid uuid NOT NULL,
    entity_type0 relationship_endpoint NOT NULL,
    entity_type1 relationship_endpoint NOT NULL,
    name non_empty_presentational_text NOT NULL,
    description non_empty_presentational_text,
    link_phrase non_empty_presentational_text NOT NULL,
    reverse_link_phrase non_empty_presentational_text NOT NULL,
    short_link_phrase non_empty_presentational_text NOT NULL,
    priority natural_integer NOT NULL DEFAULT 0,
    last_updated timestamp WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE link_type_attribute_type (
    link_type integer NOT NULL,
    attribute_type integer NOT NULL,
    min natural_integer,
    max natural_integer,
    last_updated timestamp WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE medium (
    tracklist_id integer NOT NULL,
    release_tree_id integer NOT NULL,
    position positive_integer NOT NULL,
    medium_format_id integer,
    name non_empty_presentational_text
);

CREATE TABLE medium_cdtoc (
    id serial,
    release_tree_id INTEGER NOT NULL,
    position positive_integer NOT NULL,
    cdtoc integer NOT NULL
);

CREATE TABLE medium_format (
    id serial,
    name non_empty_presentational_text NOT NULL,
    parent integer,
    child_order natural_integer NOT NULL DEFAULT 0,
    year smallint,
    has_discids boolean NOT NULL DEFAULT FALSE
);

CREATE TABLE puid (
    id serial,
    puid uuid NOT NULL,
    version integer NOT NULL
);

CREATE TABLE recording (
    recording_id uuid NOT NULL,
    master_revision_id integer NOT NULL,
    merged_into uuid
);

CREATE TABLE recording_data (
    recording_data_id serial,
    name integer NOT NULL,
    artist_credit_id integer NOT NULL,
    length positive_integer,
    comment presentational_text NOT NULL DEFAULT ''
);

CREATE TABLE recording_meta (
    recording_id uuid NOT NULL,
    rating rating,
    rating_count natural_integer NOT NULL
);

CREATE TABLE recording_puid (
    puid_id integer NOT NULL,
    recording_tree_id integer NOT NULL
);

CREATE TABLE recording_revision (
    revision_id integer NOT NULL,
    recording_id uuid NOT NULL,
    recording_tree_id integer NOT NULL
);

CREATE TABLE recording_tag (
    recording_id uuid NULL,
    tag_id integer NOT NULL,
    count positive_integer NOT NULL
);

CREATE TABLE recording_tree (
    recording_tree_id integer NOT NULL,
    recording_data_id integer NOT NULL,
    annotation text
);

CREATE TABLE release (
    release_id uuid NOT NULL,
    master_revision_id integer NOT NULL,
    merged_into uuid
);

CREATE TABLE release_tree (
    release_tree_id serial NOT NULL,
    release_data_id integer NOT NULL,
    release_group_id uuid NOT NULL,
    annotation TEXT
);

CREATE TABLE release_data (
    release_data_id serial NOT NULL,
    name integer NOT NULL,
    artist_credit_id integer NOT NULL,
    release_status_id integer,
    release_packaging_id integer,
    country_id integer,
    language_id integer,
    script_id integer,
    date partial_date,
    barcode varchar(255),
    comment presentational_text NOT NULL DEFAULT ''
);

CREATE TABLE release_meta (
    release_id uuid NOT NULL,
    date_added timestamp WITH TIME ZONE DEFAULT NOW(),
    info_url varchar(255),
    amazon_asin varchar(10),
    amazon_store varchar(20),
    cover_art_presence cover_art_presence NOT NULL DEFAULT 'absent'
);

CREATE TABLE release_coverart (
    release_id uuid NOT NULL,
    last_updated timestamp WITH TIME ZONE,
    cover_art_url varchar(255)
);

CREATE TABLE release_label (
    release_tree_id integer NOT NULL,
    label_id uuid,
    catalog_number non_empty_presentational_text
);

CREATE TABLE release_packaging (
    id serial,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE release_revision (
    revision_id integer NOT NULL,
    release_id uuid NOT NULL,
    release_tree_id integer NOT NULL
);

CREATE TABLE release_status (
    id serial,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE release_tag (
    release_id uuid NULL,
    tag_id integer NOT NULL,
    count positive_integer NOT NULL
);

CREATE TABLE release_group (
    release_group_id uuid NOT NULL,
    master_revision_id integer NOT NULL,
    merged_into uuid
);

CREATE TABLE release_group_data (
    release_group_data_id serial NOT NULL,
    name integer NOT NULL,
    artist_credit_id integer NOT NULL,
    release_group_primary_type_id integer,
    comment presentational_text NOT NULL DEFAULT ''
);

CREATE TABLE release_group_meta (
    release_group_id uuid NOT NULL,
    release_count natural_integer NOT NULL DEFAULT 0,
    first_release_date partial_date,
    rating rating,
    rating_count natural_integer NOT NULL
);

CREATE TABLE release_group_revision (
    revision_id integer NOT NULL,
    release_group_id uuid NOT NULL,
    release_group_tree_id integer NOT NULL
);

CREATE TABLE release_group_tag (
    release_group_id uuid NULL,
    tag_id integer NOT NULL,
    count positive_integer NOT NULL
);

CREATE TABLE release_group_tree (
    release_group_tree_id integer NOT NULL,
    release_group_data_id integer NOT NULL,
    annotation text
);

CREATE TABLE release_group_primary_type (
    id serial,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE release_group_secondary_type (
    id SERIAL NOT NULL,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE release_group_tree_secondary_type (
    release_group_tree_id integer NOT NULL,
    release_group_secondary_type_id integer NOT NULL
);

CREATE TABLE release_name (
    id serial,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE revision (
    revision_id serial,
    editor_id integer NOT NULL,
    created_at timestamp WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE script (
    id serial,
    iso_code char(4) NOT NULL, -- ISO 15924
    iso_number char(3) NOT NULL, -- ISO 15924
    name non_empty_presentational_text NOT NULL,
    frequency natural_integer NOT NULL DEFAULT 0
);

CREATE TABLE script_language (
    id serial,
    script integer NOT NULL,
    language integer NOT NULL,
    frequency natural_integer NOT NULL DEFAULT 0
);

CREATE TABLE tag (
    id serial,
    name non_empty_presentational_text NOT NULL,
    ref_count natural_integer NOT NULL DEFAULT 0
);

CREATE TABLE tag_relation
(
    tag1 integer NOT NULL,
    tag2 integer NOT NULL,
    weight integer NOT NULL,
    last_updated timestamp WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE track (
    recording_id UUID NOT NULL,
    tracklist_id integer NOT NULL,
    position positive_integer NOT NULL,
    name integer NOT NULL,
    artist_credit_id integer NOT NULL,
    length positive_integer,
    number non_empty_presentational_text NOT NULL
);

CREATE TABLE track_name (
    id serial,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE tracklist (
    id serial,
    track_count natural_integer NOT NULL DEFAULT 0,
    last_updated timestamp WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE tracklist_index (
    tracklist integer,
    toc cube
);

CREATE TABLE url (
    url_id uuid NOT NULL,
    master_revision_id integer NOT NULL,
    merged_into uuid
);

CREATE TABLE url_data (
    url_data_id serial NOT NULL,
    url non_empty_presentational_text NOT NULL,
    comment presentational_text NOT NULL DEFAULT ''
);

CREATE TABLE url_tree (
    url_tree_id integer NOT NULL,
    url_data_id integer NOT NULL,
    annotation text
);

CREATE TABLE url_revision (
    revision_id integer NOT NULL,
    url_id uuid NOT NULL,
    url_tree_id integer NOT NULL
);

CREATE TABLE work (
    work_id uuid NOT NULL,
    master_revision_id integer NOT NULL,
    merged_into uuid
);

CREATE TABLE work_data (
    work_data_id serial NOT NULL,
    name integer NOT NULL,
    work_type_id integer,
    comment presentational_text NOT NULL DEFAULT '',
    language_id integer
);

CREATE TABLE work_revision (
    revision_id integer NOT NULL,
    work_id uuid NOT NULL,
    work_tree_id integer NOT NULL
);

CREATE TABLE work_tree (
    work_tree_id integer NOT NULL,
    work_data_id integer NOT NULL,
    annotation text
);

CREATE TABLE work_alias_type (
    id serial,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE work_alias (
    work_tree_id integer NOT NULL,
    name integer NOT NULL,
    sort_name integer NOT NULL,
    locale locale,
    work_alias_type_id integer,
    begin_date partial_date,
    end_date partial_date,
    primary_for_locale boolean NOT NULL DEFAULT false
);

CREATE TABLE work_meta (
    work_id uuid NOT NULL,
    rating rating,
    rating_count natural_integer NOT NULL
);

CREATE TABLE work_name (
    id serial,
    name non_empty_presentational_text NOT NULL
);

CREATE TABLE work_tag (
    work_id uuid NULL,
    tag_id integer NOT NULL,
    count positive_integer NOT NULL
);

CREATE TABLE work_type (
    id serial,
    name non_empty_presentational_text NOT NULL
);

COMMIT;
