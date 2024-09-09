# GitLab Docker Compose Setup

This repository contains the necessary files to set up GitLab using Docker Compose.

## Information

Information about this project:

- All gitlab data store in `/srv/gitlab/`.
- By default, all exposed port is:

* 9101 = For SSH
* 9102 = For web (http)
* 9103 = For secure web (https)

- Default username is `root`.
- Export password with `sudo docker exec -it gitlab-ce grep 'Password:' /etc/gitlab/initial_root_password`.
- The password file is automatically deleted in the first container restart after 24 hours.

## Prerequisites

Before you start, ensure you have the following installed:

- Docker: [Install Docker](https://docs.docker.com/get-docker/)
- Docker Compose: [Install Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

- Copy `docker-compose.yml` to target server.

- Deploy and run docker-compose with `docker-compose up -d`.

## Create backup

For create backup :

1\. Create crone job to run script `backup-gitlab.sh`

2\. Run blew command:

- Create backup of config `docker exec -t gitlab-ce gitlab-backup create`
- Create backup of database `docker exec -t gitlab-ce gitlab-backup create SKIP=artifacts,repositories,registry,uploads,builds,pages,lfs,packages,terraform_state`
