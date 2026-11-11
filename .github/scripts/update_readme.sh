#!/bin/bash
# Appends the analysis result to README.md, then commits and pushes it.
FREQ_RESULT=$1
GITHUB_USER=$2
TIMESTAMP=$(date)

echo -e "\n${GITHUB_USER} - ${FREQ_RESULT} - ${TIMESTAMP}" >> README.md

# Allows the container to be run locally without pushing to the repository.
if [ "${SKIP_PUSH:-0}" = "1" ]; then
  echo "SKIP_PUSH set, not committing"
  exit 0
fi

git config --global --add safe.directory /app
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"
git add README.md
git commit -m "Update README with vowel frequency results"
git push origin HEAD:main
