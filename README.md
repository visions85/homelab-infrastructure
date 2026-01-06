# Homelab Infrastructure

Production-grade multi-server homelab demonstrating enterprise infrastructure and DevOps practices.

## 📊 Overview

- **56+ containerized services** across 11 categories
- **236TB storage infrastructure** (97% utilized) with 10TB ZFS cache pool
- **3 production domains** with automated SSL/TLS
- **Multi-tier reverse proxy** architecture
- **High-availability DNS** infrastructure
- **Full observability stack** (Prometheus, Grafana, centralized logging)

## 🏗️ Architecture

```
Internet
   ↓
Cloudflare (DNS, CDN, DDoS Protection)
   ↓
nicesrv (Nginx Reverse Proxy + Security)
   ↓
Traefik v3.0 (Service Discovery + SSL)
   ↓
Docker Services (56+ containers)
```

### Network Topology

- **Edge Security Layer**: Cloudflare → Nginx with Let's Encrypt SSL
- **Service Mesh**: Traefik with automatic service discovery
- **Network Segmentation**: 8+ isolated Docker networks (proxy, authentik, monitoring, etc.)
- **VPN Access**: Tailscale mesh VPN for secure remote administration
- **DNS Infrastructure**: BIND9 primary/secondary with DNS-over-TLS (Stubby)

## 🔧 Core Infrastructure Components

### Compute & Orchestration
- **Primary Host**: Unraid server with Docker
- **Container Runtime**: Docker Engine with Docker Compose
- **Infrastructure as Code**: Modular compose files with environment-driven config

### Networking & Security
- **Reverse Proxy**: Traefik v3.0 (service mesh) + Nginx (edge security)
- **Intrusion Detection**: CrowdSec with nginx bouncer
- **DNS**: BIND9 primary (192.168.1.21) + secondary (192.168.1.22)
- **DNS-over-TLS**: Stubby forwarding to Cloudflare
- **SSL/TLS**: Let's Encrypt with Cloudflare DNS challenge
- **VPN**: Tailscale for remote access
- **Network Management**: UniFi controller

### Identity & Access
- **SSO**: Authentik (OIDC/SAML) with PostgreSQL 16 + Redis
- **Password Management**: Vaultwarden (self-hosted Bitwarden)

### Storage
- **Total Capacity**: 236TB across array
- **Cache Pool**: 10TB ZFS for performance-critical workloads
- **Backup**: Duplicacy to remote storage

### Monitoring & Observability
- **Metrics**: Prometheus + node-exporter + cAdvisor
- **Visualization**: Grafana dashboards
- **Logging**: Centralized syslog-ng (UDP/TCP/TLS)
- **Tracing**: Jaeger for distributed tracing
- **Health Monitoring**: Container health checks + alerts

### Databases
- **PostgreSQL**: Multiple instances (v14-16) for various applications
- **MariaDB**: 11.4 for Nextcloud
- **Redis**: Caching layers for Authentik, Nextcloud, SOGo
- **InfluxDB**: Time-series metrics storage

## 📦 Service Categories

### Authentication & Security
- Authentik (SSO)
- Vaultwarden (Password Manager)

### Media & Entertainment
- Plex (hardware transcoding)
- Jellyfin (hardware transcoding)
- Immich (photo management with ML)
- Tautulli (analytics)

### Media Automation (Arr Stack)
- Sonarr (TV + Anime)
- Radarr (Movies + Anime)
- Lidarr (Music)
- Readarr (Books)
- Bazarr (Subtitles)
- Prowlarr (Indexer management)
- Overseerr (Request management)

### Collaboration & Productivity
- Nextcloud (file sync, collaboration)
- Gitea (Git hosting)
- SOGo (mail client)
- n8n (workflow automation)

### Monitoring & Operations
- Prometheus
- Grafana
- InfluxDB
- Jaeger
- Glances
- Watchtower (container updates)

### Utilities
- Duplicacy (backup management)
- Zipline (file sharing)
- Syslog-ng (centralized logging)
- Transmission (downloads)

### Web Applications
- SearXNG (privacy search)
- WeatherStar (weather display)
- Copyparty (file sharing)
- Custom static sites

### Smart Home
- Scrypted (camera management with hardware acceleration)

## 🛠️ Key Technologies

**Containerization**: Docker, Docker Compose  
**Reverse Proxy**: Traefik, Nginx  
**Monitoring**: Prometheus, Grafana, InfluxDB, Jaeger, syslog-ng  
**Databases**: PostgreSQL, MariaDB, Redis  
**Authentication**: Authentik (OIDC/SAML)  
**DNS**: BIND9, Stubby (DNS-over-TLS)  
**Networking**: Tailscale VPN, UniFi  
**Storage**: ZFS, Unraid  
**Automation**: Bash scripting, Git  
**SSL/TLS**: Let's Encrypt, Cloudflare DNS  
**Operating Systems**: Linux (Unraid, SuSE, Red Hat, Arch)

## 📁 Repository Structure

```
.
├── compose-examples/     # Sanitized Docker Compose examples
├── scripts/             # Management and automation scripts
├── docs/                # Technical documentation
├── diagrams/            # Architecture diagrams
└── README.md           # This file
```

## 🚀 Infrastructure Management

All services are managed through a modular Docker Compose architecture with:

- **Environment-driven configuration**: Per-stack `.env` files
- **Automated service management**: Custom scripts for lifecycle operations
- **Version control**: Git for infrastructure code
- **Documentation**: Comprehensive README and CHANGELOG

See `/scripts` for management automation examples.

## 📖 Documentation

- [Network Architecture](docs/network-architecture.md)
- [Service Inventory](docs/service-inventory.md)
- [CrowdSec Security](docs/security-crowdsec.md)
- [Monitoring Setup](docs/monitoring-setup.md)
- [Security Hardening](docs/security-hardening.md)

## 🎯 Design Principles

1. **Infrastructure as Code**: Everything version-controlled and reproducible
2. **Security First**: TLS everywhere, network segmentation, SSO integration
3. **Observability**: Comprehensive monitoring, logging, and tracing
4. **High Availability**: Redundant DNS, health checks, automated restarts
5. **Documentation**: Every decision documented for future reference

## 📝 Notes

This repository contains sanitized examples of my personal infrastructure setup. Secrets, API keys, and sensitive configuration have been removed or replaced with placeholders.

For questions or discussion about the architecture, feel free to open an issue.

---

**Built and maintained by David Mills** | [Resume](link-to-resume) | [LinkedIn](https://linkedin.com/in/davidsmillsjr)
