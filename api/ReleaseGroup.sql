CREATE TYPE inflated_release_group AS (
  release_group_id uuid,
  revision_id integer,
  release_group_tree_id integer,
  name text,
  release_group_primary_type_id integer,
  comment text
);

--------------------------------------------------------------------------------
CREATE FUNCTION release_groups_for_artist(in_mbid uuid)
RETURNS SETOF inflated_release_group AS $$
  SELECT
    release_group_id, revision_id, release_group_tree_id,
    name, release_group_primary_type_id, comment
  FROM (
    SELECT DISTINCT
      release_group_id, revision_id, release_group_tree_id,
      name.name, release_group_primary_type_id, comment,
      array(
        SELECT name::text
        FROM release_group_secondary_type rgst
        JOIN release_group_tree_secondary_type rgstj
          ON rgstj.release_group_secondary_type_id = rgst.id
        WHERE rgstj.release_group_tree_id = s.release_group_tree_id
        ORDER BY name ASC
      ) secondary_types,
      (
        SELECT date
        FROM release
        JOIN release_revision USING (release_id)
        JOIN release_tree USING (release_tree_id)
        JOIN release_data USING (release_data_id)
        WHERE release.master_revision_id = revision_id
          AND release_group_id = s.release_group_id
        ORDER BY (date).year NULLS LAST,
          (date).month NULLS LAST,
          (date).day NULLS LAST
        LIMIT 1
      ) earliest_release_date,
      musicbrainz_collate(name.name)
    FROM (
      SELECT release_group_id, revision_id, release_group_tree_id,
        release_group_data.*
      FROM release_group
      JOIN release_group_revision USING (release_group_id)
      JOIN release_group_tree USING (release_group_tree_id)
      JOIN release_group_data USING (release_group_data_id)
      JOIN artist_credit_name USING (artist_credit_id)
      WHERE release_group.master_revision_id = revision_id
        AND artist_credit_name.artist_id = $1
    ) s
    JOIN release_name name ON name.id = s.name
    ORDER BY
      release_group_primary_type_id, secondary_types,
      earliest_release_date, musicbrainz_collate(name.name)
  ) b;
$$ LANGUAGE SQL STABLE ROWS 1
SET search_path = nes_api, nes_playground, public;
