#!/bin/bash
set -e
source ~/venv/dbt-venv/bin/activate

export DBT_GCP_PROJECT=`gcloud config list --format 'value(core.project)' 2>/dev/null`
export USER_NAME=`gcloud config list --format 'value(core.account)' | awk -F"@" '{print $1}'`
export DBT_LOCATION="us"
export DBT_PRIORITY="interactive"
export DBT_PROFILES_DIR=.dbt
export DBT_LOG_FORMAT='text' # text, json

export DBT_VARS="{
  'project_id': ${DBT_GCP_PROJECT},
  'user_name': ${USER_NAME},
  'training_cutoff_month': '2018-08',
  'forward_prediction_end_month': '2018-08'
  }"

sqlfluff lint models/report/

# dbt --log-format ${DBT_LOG_FORMAT} snapshot --vars "${DBT_VARS}" --profiles-dir ${DBT_PROFILES_DIR} --target dev
dbt --log-format ${DBT_LOG_FORMAT} run  --vars "${DBT_VARS}" --profiles-dir ${DBT_PROFILES_DIR} --target dev
dbt --log-format ${DBT_LOG_FORMAT} test --vars "${DBT_VARS}" --profiles-dir ${DBT_PROFILES_DIR} --target dev 


python3 auto_delete_datasets.py