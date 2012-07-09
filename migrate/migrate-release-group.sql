INSERT INTO release_group_data (release_group_data_id, name, artist_credit_id,
  release_group_primary_type_id, comment)
SELECT
  id, name, artist_credit, type, coalesce(comment, '')
FROM musicbrainz.release_group;

INSERT INTO release_group_tree (release_group_tree_id, release_group_data_id)
  SELECT id, id FROM musicbrainz.release_group;

INSERT INTO release_group_tree_secondary_type (release_group_tree_id, release_group_secondary_type_id)
SELECT release_group, secondary_type FROM musicbrainz.release_group_secondary_type_join;

INSERT INTO revision (revision_id, editor_id)
  SELECT currval('revision_id_offset') + id, 4 FROM musicbrainz.release_group;

INSERT INTO release_group_revision (revision_id, release_group_tree_id, release_group_id)
  SELECT currval('revision_id_offset') + id, id, gid FROM musicbrainz.release_group;

INSERT INTO release_group (release_group_id, master_revision_id, merged_into)
  SELECT gid, currval('revision_id_offset') + id, NULL FROM musicbrainz.release_group
  UNION ALL
  SELECT gid, currval('revision_id_offset') + new_id, (SELECT gid FROM musicbrainz.release_group WHERE id=new_id)
  FROM musicbrainz.release_group_gid_redirect;

SELECT setval('revision_id_offset', currval('revision_id_offset') + (SELECT max(id) FROM musicbrainz.release_group));

INSERT INTO release_group_tag_raw (release_group_id, tag_id, editor_id)
  SELECT release_group.gid, tag, editor FROM musicbrainz.release_group_tag_raw tags
  JOIN musicbrainz.release_group ON tags.release_group = release_group.id;

INSERT INTO release_group_rating_raw (release_group_id, rating, editor_id)
  SELECT release_group.gid, rating, editor FROM musicbrainz.release_group_rating_raw ratings
  JOIN musicbrainz.release_group ON ratings.release_group = release_group.id;
