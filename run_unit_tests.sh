#!/bin/bash

dbt run  --vars '{"project_id": '$PROJECT_ID',"user_name": '$USER_NAME'}' --profiles-dir .dbt --target dev
dbt test  --vars '{"project_id": '$PROJECT_ID',"user_name": '$USER_NAME'}' --profiles-dir .dbt --target dev 
