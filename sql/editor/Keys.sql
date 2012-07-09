BEGIN;

ALTER TABLE editor ADD PRIMARY KEY (editor_id);

ALTER TABLE artist_tag_raw ADD PRIMARY KEY (artist_id, tag_id, editor_id);
ALTER TABLE artist_rating_raw ADD PRIMARY KEY (artist_id, editor_id);

ALTER TABLE label_tag_raw ADD PRIMARY KEY (label_id, tag_id, editor_id);
ALTER TABLE label_rating_raw ADD PRIMARY KEY (label_id, editor_id);

ALTER TABLE recording_tag_raw ADD PRIMARY KEY (recording_id, tag_id, editor_id);
ALTER TABLE recording_rating_raw ADD PRIMARY KEY (recording_id, editor_id);

ALTER TABLE release_group_tag_raw ADD PRIMARY KEY (release_group_id, tag_id, editor_id);
ALTER TABLE release_group_rating_raw ADD PRIMARY KEY (release_group_id, editor_id);

ALTER TABLE release_tag_raw ADD PRIMARY KEY (release_id, tag_id, editor_id);

ALTER TABLE work_tag_raw ADD PRIMARY KEY (work_id, tag_id, editor_id);
ALTER TABLE work_rating_raw ADD PRIMARY KEY (work_id, editor_id);

COMMIT;
