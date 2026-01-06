# Service Inventory

Complete inventory of all services running in the homelab infrastructure.

## Summary

- **Total Services**: 56+
- **Service Categories**: 11
- **Networks**: 8+ isolated Docker networks
- **Databases**: PostgreSQL (14-16), MariaDB 11.4, Redis
- **Storage**: 236TB total, 10TB ZFS cache

## Service Categories

### 1. Networking & Security (4 services)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| Traefik | traefik | traefik:v3.0 | proxy, monitoring | 80, 443, 8080, 8084 | Reverse proxy, service discovery |
| Cloudflare DDNS | cloudflare-ddns-lunarprops | oznu/cloudflare-ddns | - | - | Dynamic DNS updates |
| BIND9 Primary | N/A (host) | - | - | 53 | Primary DNS server |
| BIND9 Secondary | N/A (host) | - | - | 53 | Secondary DNS server |

### 2. Authentication & Security (6 services)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| Authentik Server | authentik-server | goauthentik/server:latest | proxy, authentik | 9000, 9443 | SSO server (OIDC/SAML) |
| Authentik Worker | authentik-worker | goauthentik/server:latest | authentik | - | Background tasks |
| Authentik Proxy | authentik-proxy | goauthentik/proxy | proxy | - | Forward auth proxy |
| Authentik DB | authentik-postgres | postgres:16-alpine | authentik | 5432 | PostgreSQL database |
| Authentik Cache | authentik-redis | redis:alpine | authentik | 6379 | Redis cache |
| Vaultwarden | vaultwarden | vaultwarden/server:latest | proxy | - | Password manager |

### 3. Media Stack (4 services)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| Plex | plex | linuxserver/plex | proxy | 32400 | Media server (hardware transcoding) |
| Jellyfin | jellyfin | linuxserver/jellyfin:latest | proxy | 8096, 8920 | Media server (hardware transcoding) |
| Immich | immich_server | immich-app/immich-server:v2 | proxy | - | Photo management with ML |
| Tautulli | tautulli | linuxserver/tautulli:latest | proxy | - | Plex analytics |

### 4. Media Automation - Arr Stack (12 services)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| Overseerr | overseerr | sctx/overseerr:latest | proxy, arr | - | Request management |
| Sonarr TV | sonarr-tv | linuxserver/sonarr:latest | proxy, arr | - | TV show automation |
| Sonarr Anime | sonarr-anime | linuxserver/sonarr:latest | proxy, arr | - | Anime TV automation |
| Radarr Movies | radarr-movies | linuxserver/radarr:latest | proxy, arr | - | Movie automation |
| Radarr Anime | radarr-anime | linuxserver/radarr:latest | proxy, arr | - | Anime movie automation |
| Lidarr | lidarr | linuxserver/lidarr | proxy, arr | - | Music automation |
| Readarr | readarr | hotio/readarr:nightly | proxy, arr | - | Book automation |
| Bazarr | bazarr | linuxserver/bazarr:latest | proxy, arr | - | Subtitle automation |
| Prowlarr | prowlarr | linuxserver/prowlarr | proxy, arr | - | Indexer management |
| Recyclarr | recyclarr | recyclarr/recyclarr:latest | arr | - | Quality profile automation |
| Agregarr | agregarr | agregarr/agregarr:latest | arr | - | Content aggregation |
| Traktarr | Traktarr | eafxx/traktarr:latest | arr | - | Trakt.tv integration |

### 5. Collaboration & Productivity (7 services)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| Nextcloud App | nextcloud-app | nextcloud:latest | proxy, nextcloud | - | File sync, collaboration |
| Nextcloud DB | nextcloud-db | mariadb:11.4 | nextcloud | 3306 | MariaDB database |
| Nextcloud Redis | nextcloud-redis | redis:alpine | nextcloud | 6379 | Redis cache |
| Gitea | gitea | gitea/gitea:latest | proxy, gitea | 3000, 22 | Git hosting |
| Gitea DB | gitea-db | postgres:15-alpine | gitea | 5432 | PostgreSQL database |
| SOGo | sogo | sonroyaalmerol/docker-sogo:latest | proxy, sogo-internal | - | Mail client (Fastmail backend) |
| n8n | n8n | n8nio/n8n:latest | proxy | - | Workflow automation |

### 6. Monitoring & Operations (9 services)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| Prometheus | prometheus | prom/prometheus:latest | monitoring, proxy | 9092 | Metrics collection |
| Grafana | grafana | grafana/grafana:latest | monitoring, proxy | 3000 | Metrics visualization |
| InfluxDB | InfluxDB | influxdb:latest | monitoring | 8086 | Time-series database |
| Jaeger | jaeger | jaegertracing/all-in-one:1.53 | monitoring | 16686 | Distributed tracing |
| Node Exporter | node-exporter | prom/node-exporter:latest | monitoring | 9100 | System metrics |
| cAdvisor | cadvisor | gcr.io/cadvisor/cadvisor:v0.47.0 | monitoring | 8082 | Container metrics |
| Glances | glances | nicolargo/glances:latest | monitoring | - | System monitoring |
| Watchtower | watchtower-global | containrrr/watchtower:1.7.1 | - | - | Container updates |
| Syslog-ng | syslog-server | balabit/syslog-ng:4.8.0 | proxy | 514, 6514 | Centralized logging |

### 7. Utilities & DevOps (4 services)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| Zipline | Zipline | diced/zipline:latest | proxy, zipline | - | File sharing |
| Zipline DB | zipline-db | postgres:15 | zipline | 5432 | PostgreSQL database |
| Duplicacy | Duplicacy | saspus/duplicacy-web:latest | proxy | - | Backup management |
| Transmission | transmission | linuxserver/transmission:4.0.5 | - | 9091 | Download client |

### 8. Web Applications (4 services)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| SearXNG | SearXNG | searxng/searxng:latest | proxy | - | Privacy search engine |
| WeatherStar | WeatherStar | netbymatt/ws4kp:latest | proxy | - | Weather display |
| Copyparty | Copyparty | copyparty/ac:latest | proxy | - | File sharing |
| Lunarprops Site | lunarprops-website | nginx:alpine | proxy | - | Static website |

### 9. Smart Home (1 service)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| Scrypted | scrypted | koush/scrypted:latest | host | - | Camera management (hardware acceleration) |

### 10. Downloads (2 services)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| Transmission | transmission | linuxserver/transmission:4.0.5 | - | 9091, 51413 | BitTorrent client |
| Nicotine+ | nicotine-plus | fletchto99/nicotine-plus-docker:latest | proxy, br3 | - | Soulseek client |

### 11. AI & Automation (2 services)

| Service | Container | Image | Networks | Ports | Purpose |
|---------|-----------|-------|----------|-------|---------|
| n8n | n8n | n8nio/n8n:latest | proxy | - | Workflow automation |
| Beets | beets | linuxserver/beets:latest | proxy | 8337 | Music library management |

## Resource Allocation

### CPU-Intensive Services
- Plex (hardware transcoding with /dev/dri)
- Jellyfin (hardware transcoding with /dev/dri)
- Immich (ML photo recognition)
- Scrypted (video processing)

### Memory-Intensive Services
- PostgreSQL instances (multiple)
- Redis instances (multiple)
- Prometheus (30-day retention)
- InfluxDB (time-series data)

### Storage-Intensive Services
- Plex/Jellyfin (227TB media library)
- Immich (photo storage)
- Nextcloud (file storage)
- Backups (Duplicacy)

## Network Topology

### External Networks
- **proxy**: Main Traefik network for all publicly-accessible services

### Internal Networks
- **authentik**: SSO infrastructure
- **nextcloud**: Nextcloud and database
- **arr**: Media automation stack
- **monitoring**: Observability stack
- **zipline**: File sharing
- **gitea**: Git hosting
- **sogo-internal**: Mail client
- **br3**: Special bridge network for specific services

## Health Checks

Services with configured health checks:
- authentik-postgres (pg_isready)
- authentik-redis (redis-cli ping)
- nextcloud-db (mysqladmin ping)
- gitea-db (pg_isready)
- All critical database services

## Restart Policies

All services use `restart: unless-stopped` for automatic recovery after:
- Container crashes
- System reboots
- Service updates

## Update Strategy

- **Watchtower**: Automated container updates with notifications
- **Manual updates**: Critical services (databases, Traefik)
- **Testing**: New images tested before production deployment
- **Rollback**: Previous image tags retained for quick rollback
