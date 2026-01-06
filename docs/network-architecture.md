# Network Architecture

## Overview

The homelab infrastructure implements a multi-tier security architecture with defense in depth, network segmentation, and comprehensive monitoring.

## Architecture Layers

### Layer 1: Edge Security (Internet-Facing)

**Cloudflare**
- DNS hosting with DNSSEC
- CDN and caching
- DDoS protection
- Web Application Firewall (WAF)
- SSL/TLS termination

**nicesrv - Nginx Reverse Proxy**
- External IP: Publicly routable
- OS: Linux
- Role: Edge security and SSL termination
- Features:
  - Let's Encrypt SSL automation
  - Security headers (HSTS, CSP, X-Frame-Options, etc.)
  - Cloudflare IP whitelisting
  - Request filtering
  - Multi-domain routing (lunarprops.com, dirtydata.io, lleesl.com)

### Layer 2: Service Mesh (Internal)

**Traefik v3.0**
- Container: traefik
- Role: Internal reverse proxy and service discovery
- Features:
  - Automatic service discovery via Docker labels
  - Dynamic routing
  - SSL/TLS with Cloudflare DNS challenge
  - HTTP/HTTPS entrypoints
  - Metrics endpoint for Prometheus
  - Dashboard for monitoring

### Layer 3: Application Layer

**Docker Networks**

Network segmentation provides isolation between service groups:

- **proxy** (external): Shared network for Traefik-routed services
- **authentik**: Isolated network for Authentik SSO components
- **nextcloud**: Isolated network for Nextcloud and database
- **arr**: Isolated network for media automation stack
- **zipline**: Isolated network for file sharing service
- **monitoring**: Isolated network for observability stack
- **gitea**: Isolated network for Git hosting
- **sogo-internal**: Isolated network for mail client

## DNS Infrastructure

### Primary DNS Server (bind9.0)
- IP: 192.168.1.21
- OS: Linux
- Services:
  - BIND9 primary nameserver
  - Stubby for DNS-over-TLS
  - Zone management for internal domains

### Secondary DNS Server (bind9.1)
- IP: 192.168.1.22
- OS: Linux
- Services:
  - BIND9 secondary nameserver
  - Zone transfers from primary
  - Stubby for DNS-over-TLS

### DNS-over-TLS (DoT)
- Upstream: Cloudflare (1.1.1.1, 1.0.0.1)
- Protocol: TLS 1.2/1.3
- Implementation: Stubby
- Listening: localhost:5353
- Benefits: Encrypted DNS queries, privacy, DNSSEC validation

## VPN Access

**Tailscale Mesh VPN**
- Network: 100.64.0.0/10
- Features:
  - WireGuard-based
  - Zero-config mesh networking
  - Secure remote access to infrastructure
  - Grafana integration for remote monitoring
- Use cases:
  - Remote administration
  - Secure access to internal services
  - Mobile device connectivity

## Network Management

**UniFi Controller**
- IP: 192.168.1.1 (unifi.dirtydata.box)
- Features:
  - VLAN management
  - DHCP server
  - Traffic monitoring
  - Firewall rules
  - Guest network isolation

## Traffic Flow

### External HTTPS Request Flow

```
Client Request
    ↓
Cloudflare (DNS resolution, DDoS protection)
    ↓
nicesrv:443 (Nginx - SSL termination, security headers)
    ↓
unraid:80 (Traefik - service discovery)
    ↓
Container Service (application)
```

### Internal DNS Query Flow

```
Client
    ↓
bind9.0:53 (Primary DNS)
    ↓
Stubby:5353 (DNS-over-TLS)
    ↓
Cloudflare:853 (1.1.1.1)
    ↓
Response (encrypted)
```

## Security Measures

### Transport Security
- TLS 1.2/1.3 only
- Let's Encrypt certificates (90-day rotation)
- Cloudflare DNS challenge for wildcard certs
- HSTS with preload
- DNS-over-TLS for all upstream queries

### Network Security
- Docker network segmentation
- No direct container port exposure (proxy-only access)
- Cloudflare IP whitelisting
- Tailscale VPN for remote access
- UniFi firewall rules

### Access Control
- Authentik SSO (OIDC/SAML) for centralized authentication
- Vaultwarden for password management
- SSH key-based authentication
- No password authentication on SSH
- Fail2ban on edge servers

## Monitoring

### Metrics Collection
- Prometheus scrapes Traefik metrics
- Node exporter on all hosts
- cAdvisor for container metrics
- InfluxDB for time-series data

### Logging
- Centralized syslog-ng server
- Traefik access logs
- Container logs via Docker logging driver
- UDP/TCP/TLS transport support

### Alerting
- Grafana dashboards
- Health checks on critical services
- Container restart policies

## Performance Optimization

### Caching
- Redis for Authentik and Nextcloud
- Cloudflare CDN caching
- Browser caching headers

### Load Distribution
- Traefik load balancing (when multiple replicas)
- Sticky sessions for stateful apps
- Connection pooling for databases

### Storage Tiering
- 10TB ZFS cache pool for hot data
- 236TB array for cold storage
- RAM-based transcoding scratch directories
