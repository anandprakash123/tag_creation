#!/bin/sh
# Migrate the environment-managed Portal DB and refresh Nova FDW connections

set -eux

# Kill long-running Postgres conns
# ./scripts/cancel_long_running_queries.py

## install the required packages for AWS CLI commands

# Migrate the Portal DB
alembic -x data=true downgrade $PREVIOUS_VERSION


# Migrate FDW DB
# alembic --name fdw_migration -x data=true upgrade head

# Refresh FDW conns for Portal and Gladys
# quart admin refresh-portal-fdw
# quart admin refresh-gladys-fdw
# quart admin refresh-tiling-fdw
# quart site create-service-area-for-existing-sites
