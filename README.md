# Multi-Tier Web Application Stack with Vagrant

## Overview

This project demonstrates a **multi-tier web application** deployment on local VMs using **Vagrant** and **VirtualBox**.  
The stack uses a mix of **CentOS Stream 9** and **Ubuntu 22.04 (Jammy)** VMs to simulate real-world production environments.

---

## Architecture

| VM Name | Role               | OS           | IP Address      | Main Services                  |
|---------|--------------------|--------------|-----------------|-------------------------------|
| db01    | Database Server    | CentOS Stream 9 | 192.168.56.15  | MariaDB                       |
| mc01    | Cache Server       | CentOS Stream 9 | 192.168.56.14  | Memcached                    |
| rmq01   | Message Broker     | CentOS Stream 9 | 192.168.56.13  | RabbitMQ                     |
| app01   | Application Server | CentOS Stream 9 | 192.168.56.12  | Tomcat (Java 17), Maven, Git |
| web01   | Web Server / Proxy | Ubuntu Jammy  | 192.168.56.11  | Nginx (Reverse Proxy)        |

---

## Features

- Automated provisioning of base packages and services via Vagrant shell scripts
- Proper firewall configuration on each VM
- Private networking with fixed IPs for inter-VM communication
- Modular architecture simulating production-grade environment
- Manual provisioning scripts for hands-on learning
- Planned automation using Ansible in future stages

---

## Prerequisites

- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Minimum 8GB RAM on host machine recommended

---

## Setup Instructions

### 1. Clone this repository

```bash
git clone [https://github.com/yourusername/multi-tier-web-app.git](https://github.com/hiddenclue0/vprofile.git)
cd vprofile
```

### 2. Start Vagrant VMs

```bash
vagrant up
```

This will create 5 VMs with initial software installed and services enabled.

### 3. Manual Configuration (Optional)

SSH into any VM for further manual setup or testing, for example:

```bash
vagrant ssh db01
```

You can run the respective setup scripts (e.g., `db01-setup.sh`) for advanced configuration.

### 4. Access the Application

- Visit `http://192.168.56.11` (the web server) from your host browser.
- Nginx proxies requests to the Tomcat app running on `app01`.

---

## Directory Structure

```
multi-tier-web-app/
├── Vagrantfile                # Vagrant configuration for multi-VM setup
├── scripts/                   # Shell provisioning scripts for each VM
│   ├── db01-setup.sh
│   ├── mc01-setup.sh
│   ├── rmq01-setup.sh
│   ├── app01-setup.sh
│   └── web01-setup.sh
├── docs/
│   └── architecture.png       # Diagram of multi-tier architecture (optional)
└── README.md
```

---

## Next Steps (Planned)

- Automate full provisioning and configuration with **Ansible**
- Add monitoring with **Prometheus** and **Grafana**
- Implement CI/CD pipelines with **Jenkins** or **GitHub Actions**
- Containerize application using **Docker** and orchestration with **Kubernetes**

---

## Troubleshooting

- Ensure VirtualBox extensions are installed for your OS
- Use `vagrant reload` to restart VMs if networking issues occur
- Check service status with `systemctl status <service-name>`
- View firewall status and rules with `firewall-cmd --list-all`

---

## Contact

Created by Jakir Hosen — [GitHub Profile](https://github.com/hiddenclue0)

---
