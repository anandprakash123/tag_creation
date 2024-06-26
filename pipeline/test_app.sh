#!/bin/bash
pip install -r requirements.txt
pip install dependency/slipstreamj-1.16.0-cp39-cp39-linux_x86_64.whl
pip install dependency/sparkmac-1.32.1-py3-none-any.whl
pip install .[dev]
export PGPASSWORD=${POSTGRES_PASSWORD}
createdb -O ${POSTGRES_USER} -h postgres_assets_test_db -p5432 -w -U ${POSTGRES_USER} thundercloud_test_db1
createdb -O ${POSTGRES_USER} -h postgres_assets_test_db -p5432 -w -U ${POSTGRES_USER} thundercloud_test_db2
createdb -O ${POSTGRES_USER} -h postgres_assets_test_db -p5432 -w -U ${POSTGRES_USER} gladys_dev
export PORTAL_DB_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres_portal:5432/${POSTGRES_DB}
export PORTAL_FDW_DB_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres_fdw:5432/${POSTGRES_DB}
export THUNDERCLOUD_TEST_DB1_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres_assets_test_db:5432/thundercloud_test_db1
export THUNDERCLOUD_TEST_DB2_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres_assets_test_db:5432/thundercloud_test_db2
export GLADYS_DB_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres_assets_test_db:5432/gladys_dev
export ELASTICSEARCH_URI="http://localhost:9200"
export RATELIMIT_STORAGE_HOST=redis
export RATELIMIT_STORAGE_PORT=6379
