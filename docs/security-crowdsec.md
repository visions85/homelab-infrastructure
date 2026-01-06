# CrowdSec Security on nicesrv

## Overview
nicesrv runs CrowdSec as the primary security layer for the homelab infrastructure. CrowdSec provides collaborative intrusion detection and prevention, analyzing logs to detect and block malicious behavior.

## Installation Details
- **Version**: v1.7.4 (Codename: alphaga)
- **Platform**: Debian/Linux
- **Service Type**: systemd service
- **Status**: Currently inactive (needs restart)
- **Config Location**: `/etc/crowdsec/`

## Architecture
```
Internet → nginx (reverse proxy) → CrowdSec Bouncer → Traefik (on unraid)
                                        ↓
                                  CrowdSec Agent
                                  (analyzes logs)
```

CrowdSec on nicesrv protects the nginx reverse proxy that sits in front of Traefik on the unraid server.

## Components

### CrowdSec Agent
The main detection engine that analyzes logs and identifies threats.

### Bouncers
Active remediation components that enforce decisions:

| Name | IP | Type | Version | Status |
|------|-------|------|---------|--------|
| crowdsec-nginx-bouncer | 127.0.0.1 | nginx bouncer | v1.1.3 | ✔️ Active |

The nginx bouncer integrates directly with nginx to block malicious IPs in real-time.

## Log Sources (Acquisition)
CrowdSec monitors the following log sources:

### 1. Nginx Logs
```yaml
filenames:
  - /var/log/nginx/error.log
  - /var/log/nginx/access.log
labels:
  type: nginx
```

### 2. SSH Logs
```yaml
journalctl_filter:
  - _SYSTEMD_UNIT=ssh.service
labels:
  type: syslog
```

## Installed Collections
Collections are bundles of parsers and scenarios for specific use cases:

| Collection | Purpose |
|------------|---------|
| `crowdsecurity/base-http-scenarios` | Core HTTP attack detection |
| `crowdsecurity/http-cve` | Known HTTP CVE exploits |
| `crowdsecurity/http-dos` | HTTP denial of service attacks |
| `crowdsecurity/iptables` | Network-level attacks |
| `crowdsecurity/linux` | Linux system attacks |
| `crowdsecurity/linux-lpe` | Local privilege escalation |
| `crowdsecurity/nextcloud` | Nextcloud-specific attacks |
| `crowdsecurity/nginx` | Nginx-specific attacks |
| `crowdsecurity/plex` | Plex Media Server attacks |
| `crowdsecurity/sshd` | SSH brute force and attacks |
| `crowdsecurity/whitelist-good-actors` | Legitimate service IPs |

## Key Scenarios (Attack Detection)
Notable enabled scenarios:

### Web Application Attacks
- `crowdsecurity/apache_log4j2_cve-2021-44228` - Log4Shell detection
- `crowdsecurity/http-dos-bypass-cache` - Cache bypass DoS
- `crowdsecurity/http-generic-bf` - HTTP brute force
- `crowdsecurity/http-probing` - Web scanning/probing
- `crowdsecurity/http-sensitive-files` - Sensitive file access attempts
- `ltsich/http-w00tw00t` - w00tw00t scanner detection

### CVE Exploits
- `crowdsecurity/CVE-2021-4034` - PwnKit
- `crowdsecurity/CVE-2022-26134` - Confluence RCE
- Various Spring, WordPress, and application CVEs

### SSH Protection
- `crowdsecurity/ssh-bf` - SSH brute force
- `crowdsecurity/ssh-slow-bf` - Slow SSH brute force

### Custom Scenarios
- `crowdsecurity/plex-strict` (local) - Custom Plex protection

## Parsers & Enrichment
Key parsers include:

### Enrichment
- `crowdsecurity/geoip-enrich` - Geographic IP information
- `crowdsecurity/dateparse-enrich` - Timestamp normalization

### Custom Whitelists
- `crowdsecurity/unraid-whitelist` (local) - Whitelists unraid traffic
- `crowdsecurity/whitelists` (local) - Custom whitelist rules

## Service Management

### Start CrowdSec
```bash
sudo systemctl start crowdsec
```

### Enable on Boot
```bash
sudo systemctl enable crowdsec
```

### Check Status
```bash
sudo systemctl status crowdsec
sudo cscli metrics
```

### View Decisions (Active Bans)
```bash
sudo cscli decisions list
```

### View Alerts
```bash
sudo cscli alerts list
```

## Maintenance Commands

### Update Hub
```bash
sudo cscli hub update
```

### Upgrade Collections
```bash
sudo cscli hub upgrade
```

### Add New Collection
```bash
sudo cscli collections install crowdsecurity/<collection-name>
```

### Whitelist an IP
```bash
sudo cscli decisions add --ip <IP_ADDRESS> --duration 0 --type whitelist
```

### Remove a Ban
```bash
sudo cscli decisions delete --ip <IP_ADDRESS>
```

## Integration with nginx
The nginx bouncer checks CrowdSec decisions before allowing traffic through. Configuration is typically in `/etc/nginx/` with the bouncer module loaded.

## Console & Monitoring
CrowdSec can be enrolled in the CrowdSec Console for centralized monitoring and alerts. Check enrollment status:
```bash
sudo cscli console status
```

## Threat Intelligence
CrowdSec participates in a collaborative threat intelligence network. Local decisions are shared (anonymously) to improve the global blocklist, and the local instance benefits from global threat data.

## Related Documentation
- [Network Architecture](network-architecture.md) - nicesrv's role in the network
- [Service Inventory](service-inventory.md) - All services across the homelab
