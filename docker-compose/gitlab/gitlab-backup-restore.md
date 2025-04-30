# Restoring and Using a GitLab Backup

## 1. Stop GitLab Services

Before restoring the backup, stop GitLab services to prevent conflicts.

```sh
docker-compose down
```

Or if you want to keep the container running while stopping only GitLab services inside:

```sh
docker exec -it <container_name> gitlab-ctl stop
```

Replace `<container_name>` with your GitLab container name (e.g., `gitlab_web`).

---

## 2. Locate and Transfer Backup File

By default, GitLab stores backups in `/var/opt/gitlab/backups/`.\
If your backup script stored the backup elsewhere, copy it into the GitLab container:

```sh
docker cp /path/to/backup.tar <container_name>:/var/opt/gitlab/backups/
```

---

## 3. Restore the Backup

Inside the GitLab container, restore the backup:

```sh
docker exec -it <container_name> gitlab-backup restore BACKUP=backup_timestamp
```

Replace `backup_timestamp` with the actual timestamp of your backup file (e.g., `1678901234_2023_07_05_10.3.6_gitlab_backup.tar`).

If your backup is compressed (e.g., `.tar.gz`), decompress it first:

```sh
docker exec -it <container_name> bash -c "tar -xvf /var/opt/gitlab/backups/backup_timestamp.tar -C /var/opt/gitlab/backups/"
```

---

## 4. Reconfigure GitLab

After restoring, you need to reconfigure GitLab to apply the changes:

```sh
docker exec -it <container_name> gitlab-ctl reconfigure
```

---

## 5. Restart GitLab Services

Restart the services:

```sh
docker-compose up -d
```

or inside the container:

```sh
docker exec -it <container_name> gitlab-ctl restart
```

---

## 6. Verify the Restore

Check the GitLab logs to ensure there are no errors:

```sh
docker logs -f <container_name>
```

You should now be able to access your restored GitLab instance at `http://<your-domain-or-ip>`.

---

## Additional Notes

- Ensure the backup is from the **same GitLab version** as the running container.
- If restoring to a **new server**, ensure all volumes (`gitlab-config`, `gitlab-logs`, `gitlab-data`) are properly mounted.
- If using an external database (e.g., PostgreSQL), ensure you restore the database separately.

