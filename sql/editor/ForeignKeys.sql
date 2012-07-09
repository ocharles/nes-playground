BEGIN;

ALTER TABLE artist_rating_raw ADD FOREIGN KEY (artist_id) REFERENCES artist (artist_id);
ALTER TABLE artist_rating_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);

ALTER TABLE artist_tag_raw ADD FOREIGN KEY (artist_id) REFERENCES artist (artist_id);
ALTER TABLE artist_tag_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);
ALTER TABLE artist_tag_raw ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE editor ADD FOREIGN KEY (gender_id) REFERENCES gender (id);
ALTER TABLE editor ADD FOREIGN KEY (country_id) REFERENCES country (id);

ALTER TABLE label_rating_raw ADD FOREIGN KEY (label_id) REFERENCES label (label_id);
ALTER TABLE label_rating_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);

ALTER TABLE label_tag_raw ADD FOREIGN KEY (label_id) REFERENCES label (label_id);
ALTER TABLE label_tag_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);
ALTER TABLE label_tag_raw ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE recording_rating_raw ADD FOREIGN KEY (recording_id) REFERENCES recording (recording_id);
ALTER TABLE recording_rating_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);

ALTER TABLE recording_tag_raw ADD FOREIGN KEY (recording_id) REFERENCES recording (recording_id);
ALTER TABLE recording_tag_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);
ALTER TABLE recording_tag_raw ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE release_group_rating_raw ADD FOREIGN KEY (release_group_id) REFERENCES release_group (release_group_id);
ALTER TABLE release_group_rating_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);

ALTER TABLE release_group_tag_raw ADD FOREIGN KEY (release_group_id) REFERENCES release_group (release_group_id);
ALTER TABLE release_group_tag_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);
ALTER TABLE release_group_tag_raw ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE release_tag_raw ADD FOREIGN KEY (release_id) REFERENCES release (release_id);
ALTER TABLE release_tag_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);
ALTER TABLE release_tag_raw ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE work_rating_raw ADD FOREIGN KEY (work_id) REFERENCES work (work_id);
ALTER TABLE work_rating_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);

ALTER TABLE work_tag_raw ADD FOREIGN KEY (work_id) REFERENCES work (work_id);
ALTER TABLE work_tag_raw ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);
ALTER TABLE work_tag_raw ADD FOREIGN KEY (tag_id) REFERENCES tag (id);


COMMIT;
