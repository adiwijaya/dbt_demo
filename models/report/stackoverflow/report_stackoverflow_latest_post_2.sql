SELECT
    mart_dim_stackoverflow_post.body,
    mart_dim_stackoverflow_post.creation_date,
    mart_dim_stackoverflow_post.last_edit_date,
    mart_dim_stackoverflow_post.title,
    mart_dim_stackoverflow_post.stackoverflow_posts_id,
    mart_fact_stackoverflow_post.last_edit_date AS fact_last_edit_date
FROM
    {{ ref('mart_dim_stackoverflow_post') }}
INNER JOIN
    {{ ref('mart_fact_stackoverflow_post') }}
    ON
        mart_dim_stackoverflow_post.stackoverflow_posts_id
        = mart_fact_stackoverflow_post.stackoverflow_posts_id
ORDER BY mart_fact_stackoverflow_post.last_edit_date DESC

LIMIT 10
