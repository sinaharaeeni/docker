docker exec -t gitlab-ce gitlab-backup create
docker exec -t gitlab-ce gitlab-backup create SKIP=artifacts,repositories,registry,uploads,builds,pages,lfs,packages,terraform_state
