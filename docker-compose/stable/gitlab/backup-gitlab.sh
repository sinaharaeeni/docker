#!/bin/bash
# Create automatic backup of Gitlab
# Last modify 2024/06/23
Version=1.0

# Show file version
if [[ $1 == "-v" || $1 == "--version" ]]; then
    echo "Version $Version"
    exit 0
fi

docker exec -t gitlab-ce gitlab-backup create
docker exec -t gitlab-ce gitlab-backup create SKIP=artifacts,repositories,registry,uploads,builds,pages,lfs,packages,terraform_state
