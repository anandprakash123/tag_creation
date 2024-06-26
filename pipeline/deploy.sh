#!/bin/bash
#deployment script 
export PORTAL_VERSION=$(./scripts/pipeline/new_version.sh)
echo "Deploying ${PORTAL_VERSION} to ${ENV_NAME}"
nomad job run ./nomad/koios-${ENV_NAME}.nomad
nomad job run ./nomad/koios-alert-consumer-${ENV_NAME}.nomad
nomad run ./nomad/koios-alert-pruner-${ENV_NAME}.nomad
nomad job run ./nomad/koios-data-export-scraper-${ENV_NAME}.nomad
nomad job run ./nomad/koios-data-export-scraper-load-organization-${ENV_NAME}.nomad
