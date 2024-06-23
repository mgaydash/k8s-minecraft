#!/bin/bash

# Functions
usage() {
  echo "Usage:"
  echo "    install.sh <release name> <path to values>"
}

# Script
RELEASE_NAME=${1}
VALUES_PATH=${2}

if [[ "${RELEASE_NAME}" == "" ]]; then
  usage
  exit 1
fi

if [[ "${VALUES_PATH}" == "" ]]; then
  usage
  exit 1
fi

helm upgrade \
  --install \
  --set "aws_access_key_id=${S3_ADMIN_AWS_ACCESS_KEY_ID}" \
  --set "aws_secret_access_key=${S3_ADMIN_AWS_SECRET_ACCESS_KEY}" \
  --set "minecraft.mcbackup.persistence.backupDir.existingClaim=${RELEASE_NAME}-backup" \
  --set "minecraft.persistence.dataDir.existingClaim=${RELEASE_NAME}-data" \
  --set "minecraft.minecraftServer.rcon.existingSecret=${RELEASE_NAME}-rcon-pass" \
  --set "nginx.staticSitePVC=${RELEASE_NAME}-unmined-output" \
  --values "${VALUES_PATH}" \
  "${RELEASE_NAME}" \
  .