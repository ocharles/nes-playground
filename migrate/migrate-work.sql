INSERT INTO work_data (work_data_id, name, work_type_id, comment)
SELECT
  id, name, type, coalesce(comment, '')
FROM musicbrainz.work;

INSERT INTO work_tree (work_tree_id, work_data_id)
  SELECT id, id FROM musicbrainz.work;

INSERT INTO work_alias (work_tree_id, name, sort_name, begin_date, end_date,
    primary_for_locale, work_alias_type_id, locale)
  SELECT DISTINCT ON (work, name, coalesce(locale, 'none'))
    work, name, sort_name,
    partial_date(begin_date_year, begin_date_month, begin_date_day),
    partial_date(end_date_year, end_date_month, end_date_day),
    primary_for_locale, type, locale
  FROM musicbrainz.work_alias
  ORDER BY
    work, name, coalesce(locale, 'none'),
    type NULLS LAST,
    begin_date_year NULLS LAST, begin_date_month NULLS LAST,
    begin_date_day NULLS LAST,
    end_date_year NULLS LAST, end_date_month NULLS LAST,
    end_date_day NULLS LAST;

INSERT INTO iswc (work_tree_id, iswc)
SELECT work, iswc FROM musicbrainz.iswc;

INSERT INTO revision (revision_id, editor_id)
  SELECT currval('revision_id_offset') + id, 4 FROM musicbrainz.work;

INSERT INTO work_revision (revision_id, work_tree_id, work_id)
  SELECT currval('revision_id_offset') + id, id, gid FROM musicbrainz.work;

INSERT INTO work (work_id, master_revision_id, merged_into)
  SELECT gid, currval('revision_id_offset') + id, NULL FROM musicbrainz.work
  UNION ALL
  SELECT gid, currval('revision_id_offset') + new_id, (SELECT gid FROM musicbrainz.work WHERE id=new_id)
  FROM musicbrainz.work_gid_redirect;

SELECT setval('revision_id_offset', currval('revision_id_offset') + (SELECT max(id) FROM musicbrainz.work));

INSERT INTO work_tag_raw (work_id, tag_id, editor_id)
  SELECT work.gid, tag, editor FROM musicbrainz.work_tag_raw tags
  JOIN musicbrainz.work ON tags.work = work.id;

INSERT INTO work_rating_raw (work_id, rating, editor_id)
  SELECT work.gid, rating, editor FROM musicbrainz.work_rating_raw ratings
  JOIN musicbrainz.work ON ratings.work = work.id;
