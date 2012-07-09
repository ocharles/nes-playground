INSERT INTO artist_data (artist_data_id, name, sort_name, begin_date, end_date, artist_type_id, country_id, gender_id, comment, ended)
SELECT
  id, name, sort_name,
  partial_date(begin_date_year, begin_date_month, begin_date_day),
  partial_date(end_date_year, end_date_month, end_date_day),
  type, country, gender, coalesce(comment, ''), ended
FROM musicbrainz.artist;

INSERT INTO artist_tree (artist_tree_id, artist_data_id)
  SELECT id, id FROM musicbrainz.artist;

INSERT INTO artist_alias (artist_tree_id, name, sort_name, begin_date, end_date,
    primary_for_locale, artist_alias_type_id, locale)
  SELECT DISTINCT ON (artist, name, coalesce(locale, 'none'))
    artist, name, sort_name,
    partial_date(begin_date_year, begin_date_month, begin_date_day),
    partial_date(end_date_year, end_date_month, end_date_day),
    primary_for_locale, type, locale
  FROM musicbrainz.artist_alias
  ORDER BY
    artist, name, coalesce(locale, 'none'),
    type NULLS LAST,
    begin_date_year NULLS LAST, begin_date_month NULLS LAST,
    begin_date_day NULLS LAST,
    end_date_year NULLS LAST, end_date_month NULLS LAST,
    end_date_day NULLS LAST;

INSERT INTO artist_ipi (artist_tree_id, ipi)
  SELECT artist, ipi FROM musicbrainz.artist_ipi;

INSERT INTO revision (revision_id, editor_id)
  SELECT currval('revision_id_offset') + id, 4 FROM musicbrainz.artist;

INSERT INTO artist_revision (revision_id, artist_tree_id, artist_id)
  SELECT currval('revision_id_offset') + id, id, gid FROM musicbrainz.artist;

INSERT INTO artist (artist_id, master_revision_id, merged_into)
  SELECT gid, currval('revision_id_offset') + id, NULL FROM musicbrainz.artist
  UNION ALL
  SELECT gid, currval('revision_id_offset') + new_id, (SELECT gid FROM musicbrainz.artist WHERE id=new_id)
  FROM musicbrainz.artist_gid_redirect;

SELECT setval('revision_id_offset', currval('revision_id_offset') + (SELECT max(id) FROM musicbrainz.artist));

INSERT INTO artist_tag_raw (artist_id, tag_id, editor_id)
  SELECT artist.gid, tag, editor
  FROM musicbrainz.artist_tag_raw tags
  JOIN musicbrainz.artist ON artist.id = tags.artist;

INSERT INTO artist_rating_raw (artist_id, rating, editor_id)
  SELECT artist.gid, rating, editor
  FROM musicbrainz.artist_rating_raw ratings
  JOIN musicbrainz.artist ON artist.id = ratings.artist;

INSERT INTO artist_credit (artist_credit_id)
  SELECT id FROM musicbrainz.artist_credit;

INSERT INTO artist_credit_name (artist_credit_id, artist_id, join_phrase, name, position)
  SELECT artist_credit, artist.gid, coalesce(join_phrase, ''), acn.name, position
  FROM musicbrainz.artist_credit_name acn
  JOIN musicbrainz.artist ON acn.artist = artist.id;
