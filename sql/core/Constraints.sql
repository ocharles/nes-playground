BEGIN;

CREATE FUNCTION end_date_sets_ended(end_date partial_date, ended boolean)
RETURNS boolean AS $$
  BEGIN
    RETURN
      (
        ( -- If any end date fields are not null, then ended must be true
          end_date.year IS NOT NULL OR
          end_date.month IS NOT NULL OR
          end_date.day IS NOT NULL
        ) AND ended = TRUE
      ) OR (
          -- Otherwise, all end date fields must be null
          end_date.year IS NULL AND
          end_date.month IS NULL AND
          end_date.day IS NULL
      );
  END;
$$ LANGUAGE plpgsql;

ALTER TABLE artist_data ADD CHECK ( end_date_sets_ended(end_date, ended) );

ALTER TABLE artist_alias ADD CHECK (
    (locale IS NULL AND primary_for_locale IS FALSE) OR (locale IS NOT NULL)
);

ALTER TABLE artist_alias ADD CHECK (
    (artist_alias_type_id <> 3) OR (
        artist_alias_type_id = 3 AND sort_name = name AND begin_date IS NULL AND
        end_date IS NULL AND primary_for_locale IS FALSE AND locale IS NULL
    )
);

ALTER TABLE artist_meta ADD CHECK (
    (rating IS NULL AND rating_count = 0) OR (rating IS NOT NULL)
);

ALTER TABLE label_data ADD CHECK ( end_date_sets_ended(end_date, ended) );

ALTER TABLE language ADD CHECK (
    iso_code_2t IS NOT NULL OR iso_code_3  IS NOT NULL
);

ALTER TABLE link ADD CHECK ( end_date_sets_ended(end_date, ended) );

ALTER TABLE link_type_attribute_type ADD CHECK (
  min IS NULL OR max IS NULL OR min < max
);

ALTER TABLE tag_relation ADD CHECK (
  tag1 < tag2
);

COMMIT;
