{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    partition_by = {'field': 'last_edit_date', 'data_type': 'timestamp'},
    unique_key = 'fact_stackoverflow_post_id'
  )
}}


SELECT
    stackoverflow_posts_id,
    last_edit_date,
    owner_user_id,
    FARM_FINGERPRINT(
        CONCAT(
            CAST(stackoverflow_posts_id AS STRING),
            CAST(COALESCE(last_edit_date, creation_date) AS STRING)
        )
    ) AS fact_stackoverflow_post_id
FROM
   {{ ref('stg_static_source_stackoverflow_posts_partitioned_cols_renamed') }}



{{ limit_dev() }}