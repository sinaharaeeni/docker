# Setup Server

## Create self-signed certificate for Nginx

In server bash `openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout nginx-conf.d/cert.key -out nginx-conf.d/cert.crt -subj "/CN=<host-ip-address>/O=MyCompany/OU=MyOffice"`

## Download latest version of crack tool

1. open `https://gitee.com/pengzhile/atlassian-agent/releases`
2. download latest version of atlassian-agent-vx.x.x.tar.gz (Need VPN)
3. extract file and put/replace `atlassian-agent.jar` with `./atlassian-agent.jar`

### 1- Set Variables

1. Edit `.env` file
2. Edit `postgres-init.sql` and replace password
3. Edit server ip in nginx `main.conf` file

### 2- Start Dockers

1. Start docker-compose `docker compose up -d`
2. Make sure jira, confluence and postgres containers is alive `docker ps -a`

### 3- Setup Jira

1. Open `https://<host-ip-address>/jira`
2. Click on `I'll set it up myself`
3. My Own Database
    * Database Type: `PostgreSQL`
    * Hostname: `postgres`
    * Port: `5432`
    * Database: `jiradb`
    * Username: `admin`
    * Password: `<POSTGRES_PASSWORD in .env file>`
    * Schema: `public`
4. Set up application properties
    * Base URL: `<host-ip-address>`
5. Specify your license key
    * Copy *Server ID*

### 4- Generate License Jira

In server bash `docker exec jira java -jar /opt/atlassian-agent.jar -d -n BAT -p 'jira' -o MyCompany -m <email> -s <Server-ID>`

### 5- Setup Confluence

1. Open `https://<host-ip-address>/confluence`
2. Set up your database
    * Database Type: `PostgreSQL`
    * Hostname: `postgres`
    * Port: `5432`
    * Database: `confluencedb`
    * Username: `admin`
    * Password: `<POSTGRES_PASSWORD in .env file>`
3. Set up application properties
    * Base URL: `<host-ip-address>`
4. Specify your license key
    * Copy *Server ID*

### 6- Generate License Confluence

In server bash `docker exec confluence java -jar /opt/atlassian-agent.jar -d -n BAT -p 'conf' -o MyCompany -m <email> -s <Server-ID>`

### 7- Finish Setup

1. copy generated license code to license textbox
2. Set up administrator account
3. Set up email notifications

### 8- Crack plugin

1. Install your favorite app
2. Click on *Buy now*
3. Fill below details on command
    * program-name = jira or confluence
    * plugin-name = *App key* in app details page on *Manage apps*
    * email = mail address for crack
    * Server-ID = find in *System Information > Server ID* part
4. Run command `docker exec <program-name> java -jar /opt/atlassian-agent.jar -d -n BAT -p '<plugin-name>' -o MyCompany -m <email> -s <Server-ID>`
