#!/bin/bash
DATE=$(date +%F)
BACKUP_DIR=/backup/mariadb
mkdir -p $BACKUP_DIR
docker exec -t $(docker ps -qf "ancestor=mariadb:11-ubi") \
  mysqldump -uroot -p${MYSQL_ROOT_PASSWORD} --all-databases > $BACKUP_DIR/db-backup-$DATE.sql
