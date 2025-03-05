#!/bin/bash

source config.cfg
if [[ "$1" == "--dev" ]]; then
  export START_DATE=$(date -I -d "3 days ago")
  export REPO_NAME="${REPO_NAME}-dev"
  export GITHUB_URL="https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
  echo "Running in DEV mode: START_DATE set to $START_DATE, REPO_NAME changed to $REPO_NAME"
fi

./initialize.sh
./the_line.sh
