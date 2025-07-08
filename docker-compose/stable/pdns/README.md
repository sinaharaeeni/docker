# PowerDNS Production Setup

## Services
- MariaDB (for PowerDNS backend)
- PowerDNS Master + Slave
- PowerDNS-Admin UI

## Ports
- PowerDNS-Admin: http://localhost:8080

## API Key
Set via `.env` in `PDNS_API_KEY`.

## Backup
Use `mariadb/backup.sh`. Schedule via cron:
```
0 3 * * * /path/to/backup.sh
```

# Config OS

Stop Service `sudo systemctl stop systemd-resolved`
Disable servive `sudo systemctl disable systemd-resolved`
Remove file linked to service `sudo rm -f /etc/resolv.conf`
Recreate file with host ip for local dns `echo "nameserver 172.16.26.12" | sudo tee /etc/resolv.conf`
