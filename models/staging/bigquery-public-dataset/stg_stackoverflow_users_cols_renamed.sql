SELECT id as stackoverflow_posts_id, * EXCEPT (id)
FROM {{ source('bigquery_public_data_stackoverflow', 'users') }} 

{{ limit_dev() }}