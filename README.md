*This project has been created as part of the 42 curriculum by himousta.*

# Inception

## Description
Inception is a system administration project that aims to broaden our knowledge of infrastructure by using Docker. The goal of this project is to create a complete, automated, and secure web infrastructure inside a personal Virtual Machine. 

This infrastructure relies entirely on Docker containers to isolate services. All images are built from scratch using custom Dockerfiles (based on Debian/Alpine) without relying on pre-configured services like Docker Hub. The architecture includes the mandatory core (NGINX, WordPress, MariaDB) as well as the **complete suite of bonus services**: Redis Cache, an FTP server, Adminer, a standalone Static Website, and Portainer for container management.

### Design Choices
- **Process Management:** Each container handles a single service (PID 1) and stays alive in the foreground (e.g., `php-fpm -F`, `mysqld_safe`).
- **Security:** The infrastructure forces TLSv1.2/1.3 for web traffic, uses non-root standard users where applicable, and strictly isolates credentials from the configuration files.
- **Automation:** A single `Makefile` handles the complete lifecycle (build, run, wipe) of the entire microservice ecosystem.

### Technical Comparisons

**Virtual Machines vs Docker**
Virtual Machines virtualize at the hardware level, requiring a full guest Operating System (like Ubuntu or Windows) to run on top of a hypervisor. This makes them heavy and resource-intensive. Docker virtualizes at the OS level, sharing the host machine's kernel. Containers are lightweight, boot instantly, and only contain the specific binaries and libraries needed to run the application.

**Secrets vs Environment Variables**
Environment variables are injected directly into a container's environment and can be easily exposed if a process crashes, if a user runs `printenv`, or via the `docker inspect` command. Docker Secrets are much safer; they mount sensitive data securely as temporary, read-only files in memory (usually at `/run/secrets/`), meaning the raw passwords are never exposed to the broader system environment.

**Docker Network vs Host Network**
The Host network driver removes network isolation, attaching the container directly to the host machine's network stack. A custom Docker Network (bridge) creates an isolated, private LAN exclusively for the containers. In this project, only NGINX and specific bonus services are mapped to host ports, while the database and cache communicate entirely privately on the Docker network.

**Docker Volumes vs Bind Mounts**
Docker Volumes are fully managed by Docker and stored in a protected system directory. Bind Mounts map a specific, absolute path on the host machine directly into the container. This project uses a hybrid approach: defining named volumes in Compose that act as bind mounts pointing to the `/home/himousta/data` directory for strict persistence control over WordPress and MariaDB.

## Instructions

### 1. Host Configuration
You must map the local domain to your localhost. Open `/etc/hosts` on your host machine as root:
`sudo nano /etc/hosts`
Add the following line:
`127.0.0.1 himousta.42.fr`

### 2. Compilation and Installation
Clone the repository and ensure your host machine has the required data directories:
`mkdir -p /home/himousta/data/mariadb`
`mkdir -p /home/himousta/data/wordpress`

Create a `secrets/` directory at the root of the project and populate it with the necessary password text files (e.g., `db_password.txt`, `credentials.txt`, `ftp_password.txt`). 
*(Note: Do not push this folder to Git!)*

### 3. Execution
Navigate to the root of the project and build/launch the infrastructure in the background:
`make` (or `make up`)

To stop the infrastructure:
`make down`

To completely remove containers, networks, and wipe the persistent data:
`make fclean`

## Resources
- **Docker Documentation:** https://docs.docker.com/
- **NGINX Configuration Guide:** https://nginx.org/en/docs/
- **WP-CLI Documentation:** https://make.wordpress.org/cli/handbook/
- **AI Usage:** Artificial Intelligence (LLM) was utilized during this project strictly as a debugging and theoretical tool. It was used to troubleshoot fatal crashes in bash configuration scripts, analyze Docker network port-binding conflicts, format Markdown documentation, and clarify the security differences between `.env` files and Docker Secrets to ensure strict compliance with the subject rules.