INSERT INTO recording_data (recording_data_id, name, artist_credit_id, length,
  comment)
SELECT
  id, name, artist_credit, length, coalesce(comment, '')
FROM musicbrainz.recording;

INSERT INTO recording_tree (recording_tree_id, recording_data_id)
  SELECT id, id FROM musicbrainz.recording;

INSERT INTO isrc (recording_tree_id, isrc)
SELECT recording, isrc FROM musicbrainz.isrc;

INSERT INTO recording_puid (recording_tree_id, puid_id)
SELECT recording, puid FROM musicbrainz.recording_puid;

INSERT INTO revision (revision_id, editor_id)
  SELECT currval('revision_id_offset') + id, 4 FROM musicbrainz.recording;

INSERT INTO recording_revision (revision_id, recording_tree_id, recording_id)
  SELECT currval('revision_id_offset') + id, id, gid FROM musicbrainz.recording;

INSERT INTO recording (recording_id, master_revision_id, merged_into)
  SELECT gid, currval('revision_id_offset') + id, NULL FROM musicbrainz.recording
  UNION ALL
  SELECT gid, currval('revision_id_offset') + new_id, (SELECT gid FROM musicbrainz.recording WHERE id=new_id)
  FROM musicbrainz.recording_gid_redirect;

SELECT setval('revision_id_offset', currval('revision_id_offset') + (SELECT max(id) FROM musicbrainz.recording));

INSERT INTO recording_tag_raw (recording_id, tag_id, editor_id)
  SELECT recording.gid, tag, editor FROM musicbrainz.recording_tag_raw tags
  JOIN musicbrainz.recording ON recording.id = tags.recording;

INSERT INTO recording_rating_raw (recording_id, rating, editor_id)
  SELECT recording.gid, rating, editor FROM musicbrainz.recording_rating_raw ratings
  JOIN musicbrainz.recording ON recording.id = ratings.recording;
