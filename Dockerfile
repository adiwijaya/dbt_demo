# Copyright 2021 Google LLC. This software is provided as-is, without warranty or
# representation for any use or purpose. Your use of it is subject to your agreement
# with Google.

FROM python:3.8.5

# Install required system packages and cleanup to reduce image size
RUN apt-get update -y && \
  apt-get install --no-install-recommends -y -q \
  git libpq-dev python-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy files to the image
COPY . $DBT_DIR

# Set working directory
ENV DBT_DIR /dbt/
WORKDIR $DBT_DIR

# Install data build tool
RUN pip install -U pip
RUN pip install -r requirements.txt

# Run dbt
ENTRYPOINT ["dbt"]