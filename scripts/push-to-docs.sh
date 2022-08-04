#!/usr/bin/env bash

# Expected env vars for envsubst
# BRANCH_TO_CLONE=${{ inputs.branch-to-clone }}
BRANCH_TO_CLONE=${BRANCH_TO_CLONE}
# Set default value if not set
BRANCH_TO_CLONE=${BRANCH_TO_CLONE:-master}
# API_TOKEN_GITHUB=${{ secrets.API_TOKEN_GITHUB }}
API_TOKEN_GITHUB=${API_TOKEN_GITHUB}
# REPO_TO_PUSH=${{ inputs.repo-to-push }}
REPO_TO_PUSH=${REPO_TO_PUSH}
REPO_TO_PUSH=${REPO_TO_PUSH:-docs}
# PATH_TO_PUSH=${{ inputs.path-to-push }}
PATH_TO_PUSH=${PATH_TO_PUSH}
# PATH_TO_COPY=${{ inputs.path-to-copy }}
PATH_TO_COPY=${PATH_TO_COPY}:
PATH_TO_COPY=${PATH_TO_COPY:-"docs/"}:
# REPOSITORY_NAME=${{ env.REPOSITORY_NAME }}
REPOSITORY_NAME=${REPOSITORY_NAME}


git clone --branch $BRANCH_TO_CLONE https://nvm-bot:$API_TOKEN_GITHUB@github.com/nevermined-io/$REPO_TO_PUSH.git ../_docs
cd ../_docs
mkdir -p $PATH_TO_PUSH
cp -rf ../$REPOSITORY_NAME/$PATH_TO_COPY* $PATH_TO_PUSH || true
git config --global user.email "devops@nevermined.io"
git config --global user.name "Nevermined BOT"
git add .
git commit -m "Update $REPOSITORY_NAME docs"
git push -f https://nvm-bot:$API_TOKEN_GITHUB@github.com/nevermined-io/$REPO_TO_PUSH.git
