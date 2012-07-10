CREATE TYPE inflated_artist AS (
  artist_id uuid,
  revision_id integer,
  artist_tree_id integer,
  name text,
  sort_name text,
  begin_date partial_date,
  end_date partial_date,
  artist_type_id integer,
  country_id integer,
  gender_id integer,
  comment text,
  ended boolean
);

--------------------------------------------------------------------------------
CREATE FUNCTION get_artist_by_mbid(in_mbid uuid)
RETURNS SETOF inflated_artist AS $$
  SELECT
    artist_id, revision_id, artist_tree_id,
    name.name, sort_name.name, begin_date, end_date, artist_type_id, country_id,
    gender_id, comment, ended
  FROM artist
  JOIN artist_revision USING (artist_id)
  JOIN artist_tree USING (artist_tree_id)
  JOIN artist_data USING (artist_data_id)
  JOIN artist_name name ON name.id = artist_data.name
  JOIN artist_name sort_name ON sort_name.id = artist_data.sort_name
  WHERE artist.artist_id = $1 AND artist.master_revision_id = revision_id
$$ LANGUAGE SQL STABLE ROWS 1
SET search_path = nes_api, nes_playground;

--------------------------------------------------------------------------------
CREATE FUNCTION artist_tree_ipi_codes(tree_id integer)
RETURNS TABLE (ipi ipi) AS $$
  SELECT ipi
  FROM artist_ipi
  WHERE artist_tree_id = $1
$$ LANGUAGE SQL STABLE
SET search_path = nes_api, nes_playground;
