#!/bin/bash
apt-get update 
apt-get install git -y
PORTAL_VERSION=$(./scripts/pipeline/new_version.sh)
PORTAL_ROLLBACK_VERSION=$(./scripts/pipeline/old_version.sh)
echo "Building ${ENV_NAME} Nomad manifests for ${PORTAL_VERSION}"
echo "Building ${ENV_NAME} Rollback Nomad manifests for ${PORTAL_ROLLBACK_VERSION}"


levant render -var-file=nomad/koios-${ENV_NAME}.vars.yaml -var="portal_version=${PORTAL_VERSION}" -out=nomad/koios-${ENV_NAME}.nomad nomad/koios-app.nomad.template
levant render -var-file=nomad/koios-${ENV_NAME}.vars.yaml -var="portal_version=${PORTAL_VERSION}" -out=nomad/koios-alert-consumer-${ENV_NAME}.nomad nomad/koios-alert-consumer.nomad.template
levant render -var-file=nomad/koios-${ENV_NAME}.vars.yaml -var="portal_version=${PORTAL_VERSION}" -out=nomad/koios-alert-pruner-${ENV_NAME}.nomad nomad/koios-alert-pruner.nomad.template
levant render -var-file=nomad/koios-${ENV_NAME}.vars.yaml -var="portal_version=${PORTAL_VERSION}" -out=nomad/koios-data-export-scraper-${ENV_NAME}.nomad nomad/koios-data-export-scraper.nomad.template
levant render -var-file=nomad/koios-${ENV_NAME}.vars.yaml -var="portal_version=${PORTAL_VERSION}" -out=nomad/koios-data-export-scraper-load-organization-${ENV_NAME}.nomad nomad/koios-data-export-scraper-load-organization.nomad.template
levant render -var-file=nomad/koios-${ENV_NAME}.vars.yaml -var="portal_version=${PORTAL_VERSION}" -out=nomad/koios-migrator-${ENV_NAME}.nomad nomad/koios-migrator.nomad.template

#Added rollback files for rendering

levant render -var-file=nomad/koios-${ENV_NAME}.vars.yaml -var="portal_version=${PORTAL_ROLLBACK_VERSION}" -out=nomad/koios-migrator-rollback-db-${ENV_NAME}.nomad nomad/koios-migrator-rollback-db.nomad.template
levant render -var-file=nomad/koios-${ENV_NAME}.vars.yaml -var="portal_version=${PORTAL_ROLLBACK_VERSION}" -out=nomad/koios-migrator-rollback-fdw-${ENV_NAME}.nomad nomad/koios-migrator-rollback-fdw.nomad.template
levant render -var-file=nomad/koios-${ENV_NAME}.vars.yaml -var="portal_version=${PORTAL_ROLLBACK_VERSION}" -out=nomad/koios-rollback-${ENV_NAME}.nomad nomad/koios-app.nomad.template

#Validation of the jobs

nomad job validate ./nomad/koios-${ENV_NAME}.nomad
nomad job validate ./nomad/koios-alert-consumer-${ENV_NAME}.nomad
nomad job validate ./nomad/koios-alert-pruner-${ENV_NAME}.nomad
nomad job validate ./nomad/koios-data-export-scraper-${ENV_NAME}.nomad
nomad job validate ./nomad/koios-data-export-scraper-load-organization-${ENV_NAME}.nomad
nomad job validate ./nomad/koios-migrator-${ENV_NAME}.nomad
nomad job validate ./nomad/koios-migrator-rollback-db-${ENV_NAME}.nomad
nomad job validate ./nomad/koios-migrator-rollback-fdw-${ENV_NAME}.nomad
nomad job validate ./nomad/koios-rollback-${ENV_NAME}.nomad
