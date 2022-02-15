#!/bin/bash
set -e
source ~/venv/dbt-venv/bin/activate

go install github.com/ezekg/git-hound@latest

pip3 install --upgrade pip
pip3 install -r requirements.txt
