{{ config(
    owner='data_engineer',
)}}

SELECT * FROM {{ source('bigquery_public_data', 'stackoverflow_posts') }} 
LIMIT 1000