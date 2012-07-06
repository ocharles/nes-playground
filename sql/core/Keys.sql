BEGIN;

ALTER TABLE artist ADD PRIMARY KEY (artist_id);

ALTER TABLE artist_alias ADD UNIQUE (artist_tree_id, name, locale);
CREATE UNIQUE INDEX ON artist_alias (artist_tree_id, name) WHERE locale IS NULL;

ALTER TABLE artist_alias_type ADD PRIMARY KEY (name);
ALTER TABLE artist_alias_type ADD UNIQUE (id);

ALTER TABLE artist_credit ADD PRIMARY KEY (artist_credit_id);

ALTER TABLE artist_credit_name ADD PRIMARY KEY (artist_credit_id, position);

ALTER TABLE artist_data ADD PRIMARY KEY (artist_data_id);

ALTER TABLE artist_ipi ADD PRIMARY KEY (artist_tree_id, ipi);

ALTER TABLE artist_meta ADD PRIMARY KEY (artist_id);

ALTER TABLE artist_name ADD PRIMARY KEY (name);
ALTER TABLE artist_name ADD UNIQUE (id);

ALTER TABLE artist_tag ADD PRIMARY KEY (artist_id, tag_id);

ALTER TABLE artist_tree ADD PRIMARY KEY (artist_tree_id);

ALTER TABLE artist_type ADD PRIMARY KEY (name);
ALTER TABLE artist_type ADD UNIQUE (id);

ALTER TABLE cdtoc ADD PRIMARY KEY (discid);
ALTER TABLE cdtoc ADD UNIQUE (id);

ALTER TABLE clientversion ADD PRIMARY KEY (version);
ALTER TABLE clientversion ADD UNIQUE (id);

ALTER TABLE country ADD PRIMARY KEY (iso_code);
ALTER TABLE country ADD UNIQUE (name);
ALTER TABLE country ADD UNIQUE (id);

ALTER TABLE gender ADD PRIMARY KEY (name);
ALTER TABLE gender ADD UNIQUE (id);

ALTER TABLE isrc ADD PRIMARY KEY (recording_tree_id, isrc);

ALTER TABLE iswc ADD PRIMARY KEY (work_tree_id, iswc);

ALTER TABLE label ADD PRIMARY KEY (label_id);

ALTER TABLE label_alias ADD UNIQUE (label_tree_id, name, locale);
CREATE UNIQUE INDEX ON label_alias (label_tree_id, name) WHERE locale IS NULL;

ALTER TABLE label_alias_type ADD PRIMARY KEY (name);
ALTER TABLE label_alias_type ADD UNIQUE (id);

ALTER TABLE label_data ADD PRIMARY KEY (label_data_id);

ALTER TABLE label_ipi ADD PRIMARY KEY (label_tree_id, ipi);

ALTER TABLE label_meta ADD PRIMARY KEY (label_id);

ALTER TABLE label_name ADD PRIMARY KEY (name);
ALTER TABLE label_name ADD UNIQUE (id);

ALTER TABLE label_tag ADD PRIMARY KEY (label_id, tag_id);

ALTER TABLE label_type ADD PRIMARY KEY (name);
ALTER TABLE label_type ADD UNIQUE (id);

ALTER TABLE language ADD PRIMARY KEY (id);
ALTER TABLE language ADD UNIQUE (iso_code_2t);
ALTER TABLE language ADD UNIQUE (iso_code_2b);
ALTER TABLE language ADD UNIQUE (iso_code_1);
ALTER TABLE language ADD UNIQUE (iso_code_3);
ALTER TABLE language ADD UNIQUE (name);

ALTER TABLE link ADD PRIMARY KEY (id);

ALTER TABLE link_attribute ADD PRIMARY KEY (link, attribute_type);

ALTER TABLE link_attribute_type ADD PRIMARY KEY (gid);
ALTER TABLE link_attribute_type ADD UNIQUE (id);
ALTER TABLE link_attribute_type ADD UNIQUE (name);
ALTER TABLE link_attribute_type ADD UNIQUE (description);

ALTER TABLE link_type ADD PRIMARY KEY (gid);
ALTER TABLE link_type ADD UNIQUE (id);
ALTER TABLE link_type ADD UNIQUE (name);
ALTER TABLE link_type ADD UNIQUE (description);
ALTER TABLE link_type ADD UNIQUE (link_phrase);
ALTER TABLE link_type ADD UNIQUE (reverse_link_phrase);
ALTER TABLE link_type ADD UNIQUE (short_link_phrase);

ALTER TABLE link_type_attribute_type ADD PRIMARY KEY (link_type, attribute_type);

ALTER TABLE medium ADD PRIMARY KEY (release_tree_id, position);

ALTER TABLE medium_cdtoc ADD PRIMARY KEY (release_tree_id, position, cdtoc);

ALTER TABLE medium_format ADD PRIMARY KEY (name);
ALTER TABLE medium_format ADD UNIQUE (id);

ALTER TABLE puid ADD PRIMARY KEY (puid);
ALTER TABLE puid ADD UNIQUE (id);

ALTER TABLE recording ADD PRIMARY KEY (recording_id);

ALTER TABLE recording_data ADD PRIMARY KEY (recording_data_id);

ALTER TABLE recording_meta ADD PRIMARY KEY (recording_id);

ALTER TABLE recording_tag ADD PRIMARY KEY (recording_id, tag_id);

ALTER TABLE release ADD PRIMARY KEY (release_id);

ALTER TABLE release_coverart ADD PRIMARY KEY (release_id);

ALTER TABLE release_data ADD PRIMARY KEY (release_data_id);

ALTER TABLE release_group ADD PRIMARY KEY (release_group_id);

ALTER TABLE release_group_data ADD PRIMARY KEY (release_group_data_id);

ALTER TABLE release_group_meta ADD PRIMARY KEY (release_group_id);

ALTER TABLE release_group_primary_type ADD PRIMARY KEY (name);
ALTER TABLE release_group_primary_type ADD UNIQUE (id);

ALTER TABLE release_group_secondary_type ADD PRIMARY KEY (name);
ALTER TABLE release_group_secondary_type ADD UNIQUE (id);

ALTER TABLE release_group_tag ADD PRIMARY KEY (release_group_id, tag_id);

ALTER TABLE release_group_tree_secondary_type ADD PRIMARY KEY
  (release_group_tree_id, release_group_secondary_type_id);

ALTER TABLE release_label ADD UNIQUE (release_tree_id, label_id, catalog_number);
CREATE UNIQUE INDEX ON release_label (release_tree_id, label_id) WHERE catalog_number IS NULL;
CREATE UNIQUE INDEX ON release_label (release_tree_id, catalog_number) WHERE label_id IS NULL;

ALTER TABLE release_meta ADD PRIMARY KEY (release_id);

ALTER TABLE release_name ADD PRIMARY KEY (name);
ALTER TABLE release_name ADD UNIQUE (id);

ALTER TABLE release_packaging ADD PRIMARY KEY (name);
ALTER TABLE release_packaging ADD UNIQUE (id);

ALTER TABLE release_status ADD PRIMARY KEY (name);
ALTER TABLE release_status ADD UNIQUE (id);

ALTER TABLE release_tag ADD PRIMARY KEY (release_id, tag_id);

ALTER TABLE release_tree ADD PRIMARY KEY (release_tree_id);

ALTER TABLE script ADD PRIMARY KEY (iso_code);
ALTER TABLE script ADD UNIQUE (iso_number);
ALTER TABLE script ADD UNIQUE (name);
ALTER TABLE script ADD UNIQUE (id);

ALTER TABLE script_language ADD PRIMARY KEY (script, language);
ALTER TABLE script_language ADD UNIQUE (id);

ALTER TABLE tag ADD PRIMARY KEY (name);
ALTER TABLE tag ADD UNIQUE (id);

ALTER TABLE tag_relation ADD PRIMARY KEY (tag1, tag2);

ALTER TABLE track ADD PRIMARY KEY (tracklist_id, position);

ALTER TABLE track_name ADD PRIMARY KEY (name);
ALTER TABLE track_name ADD UNIQUE (id);

ALTER TABLE tracklist ADD PRIMARY KEY (id);

ALTER TABLE tracklist_index ADD PRIMARY KEY (tracklist);

ALTER TABLE url ADD PRIMARY KEY (url_id);

ALTER TABLE url_data ADD PRIMARY KEY (url_data_id);

ALTER TABLE url_tree ADD PRIMARY KEY (url_tree_id);

ALTER TABLE work ADD PRIMARY KEY (work_id);

ALTER TABLE work_alias ADD UNIQUE (work_tree_id, name, locale);
CREATE UNIQUE INDEX ON work_alias (work_tree_id, name) WHERE locale IS NULL;

ALTER TABLE work_alias_type ADD PRIMARY KEY (name);
ALTER TABLE work_alias_type ADD UNIQUE (id);

ALTER TABLE work_data ADD PRIMARY KEY (work_data_id);

ALTER TABLE work_meta ADD PRIMARY KEY (work_id);

ALTER TABLE work_name ADD PRIMARY KEY (name);
ALTER TABLE work_name ADD UNIQUE (id);

ALTER TABLE work_tag ADD PRIMARY KEY (work_id, tag_id);

ALTER TABLE work_tree ADD PRIMARY KEY (work_tree_id);

ALTER TABLE work_type ADD PRIMARY KEY (name);
ALTER TABLE work_type ADD UNIQUE (id);

COMMIT;
