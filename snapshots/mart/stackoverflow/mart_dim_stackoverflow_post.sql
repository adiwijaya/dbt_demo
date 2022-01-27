{% snapshot ss_mart_dim_stackoverflow_post %}

{{
    config(
      target_database=var('project_id'),
      target_schema="dev_admin_mart_stackoverflow",
      unique_key='stackoverflow_posts_id',
      strategy='timestamp',
      updated_at='last_edit_date',
      partition_by={
      "field": "last_edit_date",
      "data_type": "timestamp",
      "granularity": "day"
    }
    )
}}

select * from {{ ref('mart_dim_stackoverflow_post') }}

{% endsnapshot %}