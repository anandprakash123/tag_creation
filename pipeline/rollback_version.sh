#!/bin/bash
# Release script - before script section
mkdir ~/.docker && echo "$DOCKER_AUTH_CONFIG" > ~/.docker/config.json
apk update
apk add bash git make
docker login -u gitlab-ci-token -p $CI_JOB_TOKEN $CI_REGISTRY
git config --global user.email "machine@sparkmeter.io"
git config --global user.name "SparkMeter Machine"
git remote rm gitlab || true
git remote add gitlab https://sm-machine:${MACHINE_ACCESS_TOKEN}@gitlab.com/${CI_PROJECT_PATH}.git
git remote -v


# Script section
source ./scripts/pipeline/new_version.sh
VERSION=$old_version
echo $VERSION
echo $VERSION > version_rollback_file
