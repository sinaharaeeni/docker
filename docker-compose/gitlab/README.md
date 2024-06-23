deploy and run with `docker-compose up -d`

all gitlab data store in `/srv/gitlab/`
all gitlab-runner data store in `/srv/gitlab-runner/`

need to define hostname in yaml file. now set on `gitlab.sinaharaeeni.ir`

by default, all exposed port is:

*22=for ssh
*80=for web (http)
*443=for secure web (https)

default username is `root`
export password with `sudo docker exec -it gitlab-ce grep 'Password:' /etc/gitlab/initial_root_password`

for create backup can run `docker exec -t gitlab-ce gitlab-backup create`

for create database backup `docker exec -t gitlab-ce gitlab-backup create SKIP=artifacts,repositories,registry,uploads,builds,pages,lfs,packages,terraform_state`

gitlab-runner register  --url http://gitlab.sinaharaeeni.ir  --token glrt-wyCBMnh5yzx58zh_QQDe