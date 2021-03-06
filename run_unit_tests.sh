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

echo "SQL Linting using SQL Fluff"
sqlfluff lint models/report/

echo "Secrets Scanner using Git Hound"
git hound sniff

echo "dbt unit tests"
dbt deps --profiles-dir ${DBT_PROFILES_DIR} --vars "${DBT_VARS}" --target dev 
dbt --log-format ${DBT_LOG_FORMAT} snapshot --vars "${DBT_VARS}" --profiles-dir ${DBT_PROFILES_DIR} --target dev
dbt --log-format ${DBT_LOG_FORMAT} run  --vars "${DBT_VARS}" --profiles-dir ${DBT_PROFILES_DIR} --target dev $1 $2
dbt --log-format ${DBT_LOG_FORMAT} test --vars "${DBT_VARS}" --profiles-dir ${DBT_PROFILES_DIR} --target dev $1
dbt --log-format ${DBT_LOG_FORMAT} docs generate --vars "${DBT_VARS}" --profiles-dir ${DBT_PROFILES_DIR} --target dev $1

echo "Test coverage using dbt-coverage"
dbt-coverage compute doc --cov-fail-under 0.1