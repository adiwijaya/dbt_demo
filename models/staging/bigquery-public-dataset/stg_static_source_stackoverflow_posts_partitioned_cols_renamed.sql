SELECT id as stackoverflow_posts_id, * EXCEPT (id)
FROM {{ source('pso_dbt_airflow_demo_static_source', 'stackoverflow_posts_partitioned') }} 

{{ limit_dev() }}