INSERT INTO release_data (release_data_id, name, artist_credit_id,
  release_status_id, release_packaging_id, country_id, language_id, script_id,
  date, barcode, comment)
SELECT
  id, name, artist_credit, status, packaging, country, language, script,
  partial_date(date_year, date_month, date_day), barcode, coalesce(comment, '')
FROM musicbrainz.release;

INSERT INTO release_tree (release_tree_id, release_data_id, release_group_id)
  SELECT release.id, release.id, release_group.gid
  FROM musicbrainz.release
  JOIN musicbrainz.release_group ON release_group.id = release.release_group;

INSERT INTO release_label (release_tree_id, label_id, catalog_number)
SELECT DISTINCT ON (release, coalesce(label, 0), coalesce(catalog_number, ''))
  release, label.gid, catalog_number
  FROM musicbrainz.release_label
  JOIN musicbrainz.label ON release_label.label = label.id;

INSERT INTO revision (revision_id, editor_id)
  SELECT currval('revision_id_offset') + id, 4 FROM musicbrainz.release;

INSERT INTO release_revision (revision_id, release_tree_id, release_id)
  SELECT currval('revision_id_offset') + id, id, gid FROM musicbrainz.release;

INSERT INTO release (release_id, master_revision_id, merged_into)
  SELECT gid, currval('revision_id_offset') + id, NULL FROM musicbrainz.release
  UNION ALL
  SELECT gid, currval('revision_id_offset') + new_id, (SELECT gid FROM musicbrainz.release WHERE id=new_id)
  FROM musicbrainz.release_gid_redirect;

SELECT setval('revision_id_offset', currval('revision_id_offset') + (SELECT max(id) FROM musicbrainz.release));

INSERT INTO release_tag_raw (release_id, tag_id, editor_id)
  SELECT release.gid, tag, editor FROM musicbrainz.release_tag_raw tags
  JOIN musicbrainz.release ON release.id = tags.release;

INSERT INTO tracklist (id)
  SELECT id FROM musicbrainz.tracklist;

INSERT INTO track (name, length, position, number, artist_credit_id, tracklist_id, recording_id)
  SELECT track.name, track.length, position, number, track.artist_credit, tracklist, recording.gid
  FROM musicbrainz.track JOIN musicbrainz.recording ON recording.id = track.recording;

INSERT INTO medium (tracklist_id, position, medium_format_id, name, release_tree_id)
  SELECT tracklist, position, format, name, release
  FROM musicbrainz.medium;
