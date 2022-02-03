SELECT 
stackoverflow_posts_id,
title,
body,
creation_date,
last_edit_date
FROM {{ ref('stg_static_source_stackoverflow_posts_partitioned_cols_renamed') }} 

{{ limit_dev() }}