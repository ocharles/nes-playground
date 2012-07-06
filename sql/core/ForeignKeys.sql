BEGIN;

ALTER TABLE artist ADD FOREIGN KEY (master_revision_id) REFERENCES artist_revision (revision_id);
ALTER TABLE artist ADD FOREIGN KEY (merged_into) REFERENCES artist (artist_id);

ALTER TABLE artist_alias ADD FOREIGN KEY (artist_tree_id) REFERENCES artist_tree (artist_tree_id);
ALTER TABLE artist_alias ADD FOREIGN KEY (name) REFERENCES artist_name (id);
ALTER TABLE artist_alias ADD FOREIGN KEY (sort_name) REFERENCES artist_name (id);
ALTER TABLE artist_alias ADD FOREIGN KEY (artist_alias_type_id) REFERENCES artist_alias_type (id);

ALTER TABLE artist_credit ADD FOREIGN KEY (name) REFERENCES artist_name (id);

ALTER TABLE artist_credit_name ADD FOREIGN KEY (artist_credit_id) REFERENCES artist_credit (artist_credit_id);
ALTER TABLE artist_credit_name ADD FOREIGN KEY (artist_id) REFERENCES artist (artist_id);
ALTER TABLE artist_credit_name ADD FOREIGN KEY (name) REFERENCES artist_name (id);

ALTER TABLE artist_data ADD FOREIGN KEY (name) REFERENCES artist_name (id);
ALTER TABLE artist_data ADD FOREIGN KEY (sort_name) REFERENCES artist_name (id);
ALTER TABLE artist_data ADD FOREIGN KEY (artist_type_id) REFERENCES artist_type (id);
ALTER TABLE artist_data ADD FOREIGN KEY (country_id) REFERENCES country (id);
ALTER TABLE artist_data ADD FOREIGN KEY (gender_id) REFERENCES gender (id);

ALTER TABLE artist_ipi ADD FOREIGN KEY (artist_tree_id) REFERENCES artist_tree (artist_tree_id);

ALTER TABLE artist_meta ADD FOREIGN KEY (artist_id) REFERENCES artist (artist_id);

ALTER TABLE artist_revision ADD FOREIGN KEY (artist_id) REFERENCES artist (artist_id);
ALTER TABLE artist_revision ADD FOREIGN KEY (revision_id) REFERENCES revision (revision_id);
ALTER TABLE artist_revision ADD FOREIGN KEY (artist_tree_id) REFERENCES artist_tree (artist_tree_id);

ALTER TABLE artist_tag ADD FOREIGN KEY (artist_id) REFERENCES artist (artist_id);
ALTER TABLE artist_tag ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE artist_tree ADD FOREIGN KEY (artist_data_id) REFERENCES artist_data (artist_data_id);

ALTER TABLE isrc ADD FOREIGN KEY (recording_tree_id) REFERENCES recording_tree (recording_tree_id);

ALTER TABLE iswc ADD FOREIGN KEY (work_tree_id) REFERENCES work_tree (work_tree_id);

ALTER TABLE label ADD FOREIGN KEY (master_revision_id) REFERENCES label_revision (revision_id);
ALTER TABLE label ADD FOREIGN KEY (merged_into) REFERENCES label (label_id);

ALTER TABLE label_alias ADD FOREIGN KEY (label_tree_id) REFERENCES label_tree (label_tree_id);
ALTER TABLE label_alias ADD FOREIGN KEY (name) REFERENCES label_name (id);
ALTER TABLE label_alias ADD FOREIGN KEY (sort_name) REFERENCES label_name (id);
ALTER TABLE label_alias ADD FOREIGN KEY (label_alias_type_id) REFERENCES label_alias_type (id);

ALTER TABLE label_data ADD FOREIGN KEY (name) REFERENCES label_name (id);
ALTER TABLE label_data ADD FOREIGN KEY (sort_name) REFERENCES label_name (id);
ALTER TABLE label_data ADD FOREIGN KEY (label_type_id) REFERENCES label_type (id);
ALTER TABLE label_data ADD FOREIGN KEY (country_id) REFERENCES country (id);

ALTER TABLE label_ipi ADD FOREIGN KEY (label_tree_id) REFERENCES label_tree (label_tree_id);

ALTER TABLE label_meta ADD FOREIGN KEY (label_id) REFERENCES label (label_id);

ALTER TABLE label_revision ADD FOREIGN KEY (label_id) REFERENCES label (label_id);
ALTER TABLE label_revision ADD FOREIGN KEY (revision_id) REFERENCES revision (revision_id);
ALTER TABLE label_revision ADD FOREIGN KEY (label_tree_id) REFERENCES label_tree (label_tree_id);

ALTER TABLE label_tag ADD FOREIGN KEY (label_id) REFERENCES label (label_id);
ALTER TABLE label_tag ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE label_tree ADD FOREIGN KEY (label_data_id) REFERENCES label_data (label_data_id);

ALTER TABLE link ADD FOREIGN KEY (link_type) REFERENCES link_type (id);

ALTER TABLE link_attribute ADD FOREIGN KEY (link) REFERENCES link (id);
ALTER TABLE link_attribute ADD FOREIGN KEY (attribute_type) REFERENCES link_attribute_type (id);

ALTER TABLE link_attribute_type ADD FOREIGN KEY (parent) REFERENCES link_attribute_type (id);
ALTER TABLE link_attribute_type ADD FOREIGN KEY (root) REFERENCES link_attribute_type (id);

ALTER TABLE link_type ADD FOREIGN KEY (parent) REFERENCES link_type (id);

ALTER TABLE link_type_attribute_type ADD FOREIGN KEY (link_type) REFERENCES link_type (id);
ALTER TABLE link_type_attribute_type ADD FOREIGN KEY (attribute_type) REFERENCES link_attribute_type (id);

ALTER TABLE medium ADD FOREIGN KEY (tracklist_id) REFERENCES tracklist (id);
ALTER TABLE medium ADD FOREIGN KEY (release_tree_id) REFERENCES release_tree (release_tree_id);
ALTER TABLE medium ADD FOREIGN KEY (format) REFERENCES medium_format (id);

ALTER TABLE medium_cdtoc ADD FOREIGN KEY (release_tree_id, position) REFERENCES medium (release_tree_id, position);
ALTER TABLE medium_cdtoc ADD FOREIGN KEY (cdtoc) REFERENCES cdtoc (id);

ALTER TABLE medium_format ADD FOREIGN KEY (parent) REFERENCES medium_format (id);

ALTER TABLE recording ADD FOREIGN KEY (master_revision_id) REFERENCES recording_revision (revision_id);
ALTER TABLE recording ADD FOREIGN KEY (merged_into) REFERENCES recording (recording_id);

ALTER TABLE recording_data ADD FOREIGN KEY (name) REFERENCES track_name (id);
ALTER TABLE recording_data ADD FOREIGN KEY (artist_credit_id) REFERENCES artist_credit (artist_credit_id);

ALTER TABLE recording_meta ADD FOREIGN KEY (recording_id) REFERENCES recording (recording_id);

ALTER TABLE recording_puid ADD FOREIGN KEY (recording_tree_id) REFERENCES recording_tree (recording_tree_id);
ALTER TABLE recording_puid ADD FOREIGN KEY (puid_id) REFERENCES puid (id);

ALTER TABLE recording_revision ADD FOREIGN KEY (recording_id) REFERENCES recording (recording_id);
ALTER TABLE recording_revision ADD FOREIGN KEY (revision_id) REFERENCES revision (revision_id);
ALTER TABLE recording_revision ADD FOREIGN KEY (recording_tree_id) REFERENCES recording_tree (recording_tree_id);

ALTER TABLE recording_tag ADD FOREIGN KEY (recording_id) REFERENCES recording (recording_id);
ALTER TABLE recording_tag ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE recording_tree ADD FOREIGN KEY (recording_data_id) REFERENCES recording_data (recording_data_id);

ALTER TABLE release ADD FOREIGN KEY (master_revision_id) REFERENCES release_revision (revision_id);
ALTER TABLE release ADD FOREIGN KEY (merged_into) REFERENCES release (release_id);

ALTER TABLE release_coverart ADD FOREIGN KEY (release_id) REFERENCES release (release_id);

ALTER TABLE release_data ADD FOREIGN KEY (name) REFERENCES release_name (id);
ALTER TABLE release_data ADD FOREIGN KEY (release_status_id) REFERENCES release_status (id);
ALTER TABLE release_data ADD FOREIGN KEY (release_packaging_id) REFERENCES release_packaging (id);
ALTER TABLE release_data ADD FOREIGN KEY (country_id) REFERENCES country (id);
ALTER TABLE release_data ADD FOREIGN KEY (language_id) REFERENCES language (id);
ALTER TABLE release_data ADD FOREIGN KEY (script_id) REFERENCES script (id);

ALTER TABLE release_group ADD FOREIGN KEY (master_revision_id) REFERENCES release_group_revision (revision_id);
ALTER TABLE release_group ADD FOREIGN KEY (merged_into) REFERENCES release_group (release_group_id);

ALTER TABLE release_group_data ADD FOREIGN KEY (artist_credit_id) REFERENCES artist_credit (artist_credit_id);
ALTER TABLE release_group_data ADD FOREIGN KEY (release_group_primary_type_id)
  REFERENCES release_group_primary_type (id);
ALTER TABLE release_group_data ADD FOREIGN KEY (name) REFERENCES release_name (id);

ALTER TABLE release_group_meta ADD FOREIGN KEY (release_group_id) REFERENCES release_group (release_group_id);

ALTER TABLE release_group_revision ADD FOREIGN KEY (release_group_id) REFERENCES release_group (release_group_id);
ALTER TABLE release_group_revision ADD FOREIGN KEY (revision_id) REFERENCES revision (revision_id);
ALTER TABLE release_group_revision ADD FOREIGN KEY (release_group_tree_id) REFERENCES release_group_tree (release_group_tree_id);

ALTER TABLE release_group_tag ADD FOREIGN KEY (release_group_id) REFERENCES release_group (release_group_id);
ALTER TABLE release_group_tag ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE release_group_tree ADD FOREIGN KEY (release_group_data_id) REFERENCES release_group_data (release_group_data_id);

ALTER TABLE release_group_tree_secondary_type ADD FOREIGN KEY (release_group_secondary_type_id)
  REFERENCES release_group_secondary_type (id);

ALTER TABLE release_label ADD FOREIGN KEY (label_id) REFERENCES label (label_id);
ALTER TABLE release_label ADD FOREIGN KEY (release_tree_id) REFERENCES release_tree (release_tree_id);

ALTER TABLE release_meta ADD FOREIGN KEY (release_id) REFERENCES release (release_id);

ALTER TABLE release_revision ADD FOREIGN KEY (release_id) REFERENCES release (release_id);
ALTER TABLE release_revision ADD FOREIGN KEY (revision_id) REFERENCES revision (revision_id);
ALTER TABLE release_revision ADD FOREIGN KEY (release_tree_id) REFERENCES release_tree (release_tree_id);

ALTER TABLE release_tag ADD FOREIGN KEY (release_id) REFERENCES release (release_id);
ALTER TABLE release_tag ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE release_tree ADD FOREIGN KEY (release_data_id) REFERENCES release_data (release_data_id);

ALTER TABLE revision ADD FOREIGN KEY (editor_id) REFERENCES editor (editor_id);

ALTER TABLE script_language ADD FOREIGN KEY (script) REFERENCES script (id);
ALTER TABLE script_language ADD FOREIGN KEY (language) REFERENCES language (id);

ALTER TABLE tag_relation ADD FOREIGN KEY (tag1) REFERENCES tag (id);
ALTER TABLE tag_relation ADD FOREIGN KEY (tag2) REFERENCES tag (id);

ALTER TABLE track ADD FOREIGN KEY (name) REFERENCES track_name (id);
ALTER TABLE track ADD FOREIGN KEY (tracklist_id) REFERENCES tracklist (id);
ALTER TABLE track ADD FOREIGN KEY (recording_id) REFERENCES recording (recording_id);
ALTER TABLE track ADD FOREIGN KEY (artist_credit_id) REFERENCES artist_credit (artist_credit_id);

ALTER TABLE tracklist_index ADD FOREIGN KEY (tracklist) REFERENCES tracklist (id);

ALTER TABLE url ADD FOREIGN KEY (master_revision_id) REFERENCES url_revision (revision_id);
ALTER TABLE url ADD FOREIGN KEY (merged_into) REFERENCES url (url_id);

ALTER TABLE url_revision ADD FOREIGN KEY (url_id) REFERENCES url (url_id);
ALTER TABLE url_revision ADD FOREIGN KEY (revision_id) REFERENCES revision (revision_id);
ALTER TABLE url_revision ADD FOREIGN KEY (url_tree_id) REFERENCES url_tree (url_tree_id);

ALTER TABLE url_tree ADD FOREIGN KEY (url_data_id) REFERENCES url_data (url_data_id);

ALTER TABLE work ADD FOREIGN KEY (master_revision_id) REFERENCES work_revision (revision_id);
ALTER TABLE work ADD FOREIGN KEY (merged_into) REFERENCES work (work_id);

ALTER TABLE work_alias ADD FOREIGN KEY (work_tree_id) REFERENCES work_tree (work_tree_id);
ALTER TABLE work_alias ADD FOREIGN KEY (name) REFERENCES work_name (id);
ALTER TABLE work_alias ADD FOREIGN KEY (sort_name) REFERENCES work_name (id);
ALTER TABLE work_alias ADD FOREIGN KEY (work_alias_type_id) REFERENCES work_alias_type (id);

ALTER TABLE work_data ADD FOREIGN KEY (name) REFERENCES work_name (id);
ALTER TABLE work_data ADD FOREIGN KEY (work_type_id) REFERENCES work_type (id);
ALTER TABLE work_data ADD FOREIGN KEY (language_id) REFERENCES language (id);

ALTER TABLE work_meta ADD FOREIGN KEY (work_id) REFERENCES work (work_id);

ALTER TABLE work_revision ADD FOREIGN KEY (work_id) REFERENCES work (work_id);
ALTER TABLE work_revision ADD FOREIGN KEY (revision_id) REFERENCES revision (revision_id);
ALTER TABLE work_revision ADD FOREIGN KEY (work_tree_id) REFERENCES work_tree (work_tree_id);

ALTER TABLE work_tag ADD FOREIGN KEY (work_id) REFERENCES work (work_id);
ALTER TABLE work_tag ADD FOREIGN KEY (tag_id) REFERENCES tag (id);

ALTER TABLE work_tree ADD FOREIGN KEY (work_data_id) REFERENCES work_data (work_data_id);

COMMIT;
