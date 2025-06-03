# PowerDNS Production Setup

## Services
- MariaDB (for PowerDNS backend)
- PowerDNS Master + Slave
- PowerDNS-Admin UI
- phpMyAdmin for DB management

## Ports
- PowerDNS-Admin: http://localhost:8080
- phpMyAdmin: http://localhost:80

## API Key
Set via `.env` in `PDNS_API_KEY`.

## Backup
Use `mariadb/backup.sh`. Schedule via cron:
```
0 3 * * * /path/to/backup.sh
```
