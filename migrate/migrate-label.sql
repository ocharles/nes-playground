INSERT INTO label_data (label_data_id, name, sort_name, begin_date, end_date,
  label_code, label_type_id, comment, ended)
SELECT
  id, name, sort_name,
  partial_date(begin_date_year, begin_date_month, begin_date_day),
  partial_date(end_date_year, end_date_month, end_date_day),
  label_code, type, coalesce(comment, ''), ended
FROM musicbrainz.label;

INSERT INTO label_tree (label_tree_id, label_data_id)
  SELECT id, id FROM musicbrainz.label;

INSERT INTO label_alias (label_tree_id, name, sort_name, begin_date, end_date,
    primary_for_locale, label_alias_type_id, locale)
  SELECT DISTINCT ON (label, name, coalesce(locale, 'none'))
    label, name, sort_name,
    partial_date(begin_date_year, begin_date_month, begin_date_day),
    partial_date(end_date_year, end_date_month, end_date_day),
    primary_for_locale, type, locale
  FROM musicbrainz.label_alias
  ORDER BY
    label, name, coalesce(locale, 'none'),
    type NULLS LAST,
    begin_date_year NULLS LAST, begin_date_month NULLS LAST,
    begin_date_day NULLS LAST,
    end_date_year NULLS LAST, end_date_month NULLS LAST,
    end_date_day NULLS LAST;

INSERT INTO label_ipi (label_tree_id, ipi)
  SELECT label, ipi FROM musicbrainz.label_ipi;

INSERT INTO revision (revision_id, editor_id)
  SELECT currval('revision_id_offset') + id, 4 FROM musicbrainz.label;

INSERT INTO label_revision (revision_id, label_tree_id, label_id)
  SELECT currval('revision_id_offset') + id, id, gid FROM musicbrainz.label;

INSERT INTO label (label_id, master_revision_id, merged_into)
  SELECT gid, currval('revision_id_offset') + id, NULL FROM musicbrainz.label
  UNION ALL
  SELECT gid, currval('revision_id_offset') + new_id, (SELECT gid FROM musicbrainz.label WHERE id=new_id)
  FROM musicbrainz.label_gid_redirect;

SELECT setval('revision_id_offset', currval('revision_id_offset') + (SELECT max(id) FROM musicbrainz.label));

INSERT INTO label_tag_raw (label_id, tag_id, editor_id)
  SELECT label.gid, tag, editor FROM musicbrainz.label_tag_raw tags
  JOIN musicbrainz.label ON label.id = tags.label;

INSERT INTO label_rating_raw (label_id, rating, editor_id)
  SELECT label.gid, rating, editor FROM musicbrainz.label_rating_raw ratings
  JOIN musicbrainz.label ON label.id = ratings.label;
