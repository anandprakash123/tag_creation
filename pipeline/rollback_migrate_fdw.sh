#!/bin/sh
# Migrate the environment-managed Portal DB and refresh Nova FDW connections

set -eux


apt-get update
apt-get install -y awscli

## retrive the latest successful deployed version

aws s3 cp ${BUCKET_NAME}/${ENV_NAME}-fdw-version.txt ${ENV_NAME}-fdw-version.txt

PREVIOUS_VERSION=`cat ${ENV_NAME}-fdw-version.txt`

# Migrate the Portal DB
alembic -x data=true --name fdw_migration downgrade $PREVIOUS_VERSION
