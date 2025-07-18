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
chmod +x pdns/backup.sh

Use `backup.sh`. Schedule via cron:
```

30 2 * * * /bin/bash /root/pdns/backup.sh >> /root/pdns/backup/backup.log 2>&1

```

# Config OS

Stop Service `sudo systemctl stop systemd-resolved`
Disable servive `sudo systemctl disable systemd-resolved`
Remove file linked to service `sudo rm -f /etc/resolv.conf`
Recreate file with host ip for local dns `echo "nameserver 172.16.26.12" | sudo tee /etc/resolv.conf`


اگر خود دامنه هم روی این سرور resolve میشود باید سرور دو تا آی چی داشته باشد که یکی به درخواست های دامنه valid پاسخ بدهد و دیگری به درخواست های داخل چون محدودیت گذاشتم که فقط از مبدا های لوکال جواب بده