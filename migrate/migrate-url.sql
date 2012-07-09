INSERT INTO url_data (url_data_id, url, comment)
SELECT
  id, url, coalesce(description, '')
FROM musicbrainz.url;

INSERT INTO url_tree (url_tree_id, url_data_id)
  SELECT id, id FROM musicbrainz.url;

INSERT INTO revision (revision_id, editor_id)
  SELECT currval('revision_id_offset') + id, 4 FROM musicbrainz.url;

INSERT INTO url_revision (revision_id, url_tree_id, url_id)
  SELECT currval('revision_id_offset') + id, id, gid FROM musicbrainz.url;

INSERT INTO url (url_id, master_revision_id, merged_into)
  SELECT gid, currval('revision_id_offset') + id, NULL FROM musicbrainz.url
  UNION ALL
  SELECT gid, currval('revision_id_offset') + new_id, (SELECT gid FROM musicbrainz.url WHERE id=new_id)
  FROM musicbrainz.url_gid_redirect;

SELECT setval('revision_id_offset', currval('revision_id_offset') + (SELECT max(id) FROM musicbrainz.url));
