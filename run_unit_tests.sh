#!/bin/bash
export PROJECT_ID='pso-dbt-airflow-demo'
export USER_NAME='admin_adiwijaya_me'

dbt run  --vars '{"project_id": '$PROJECT_ID',"user_name": '$USER_NAME'}' --profiles-dir .dbt 
dbt test  --vars '{"project_id": '$PROJECT_ID',"user_name": '$USER_NAME'}' --profiles-dir .dbt 
