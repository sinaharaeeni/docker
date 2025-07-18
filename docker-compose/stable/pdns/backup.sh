#!/bin/bash

# =========================
# Docker MariaDB Backup Script
# =========================

set -e

# Define PATH for cron environments
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Resolve working directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Load .env file if exists
[ -f .env ] && export $(grep -v '^#' .env | xargs)

# Backup file config
DATE=$(date +%F-%H%M)
BACKUP_DIR="$SCRIPT_DIR/backup"
FILENAME="db-backup-$DATE.sql.gz"
FULL_PATH="$BACKUP_DIR/$FILENAME"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Get container ID
CONTAINER_ID=$(docker ps -qf "name=mariadb")
if [ -z "$CONTAINER_ID" ]; then
  echo "⛔ MariaDB container not found!"
  exit 1
fi

# Start backup
echo "📦 Starting MySQL backup..."
docker exec -t "$CONTAINER_ID" \
  mysqldump -uroot -p"${MYSQL_ROOT_PASSWORD}" --all-databases \
  | gzip > "$FULL_PATH"

# Check success
if [ $? -eq 0 ]; then
  echo "✅ Backup successful: $FULL_PATH"
else
  echo "❌ Backup failed!"
  exit 2
fi

# Delete old backups (older than 7 days)
echo "🧹 Cleaning up old backups..."
find "$BACKUP_DIR" -name "db-backup-*.sql.gz" -type f -mtime +7 -exec rm -f {} \;

echo "✅ Done."
