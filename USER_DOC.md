# User Documentation

## Services Provided by the Stack
This infrastructure provides a complete web-hosting environment with advanced administration and caching features:
- **NGINX:** The main web server/proxy that handles all incoming traffic. It only accepts secure HTTPS connections (TLSv1.2 or TLSv1.3).
- **WordPress:** A fully functional Content Management System (CMS) ready for publishing.
- **MariaDB:** A relational database securely storing the WordPress user data and site configurations.
- **Redis (Bonus):** An in-memory cache that drastically speeds up WordPress database queries and load times.
- **FTP (Bonus):** A File Transfer Protocol server allowing users to manage WordPress backend files remotely.
- **Adminer (Bonus):** A lightweight database management tool allowing administrators to visualize and edit MariaDB graphically.
- **Static Website (Bonus):** A standalone webpage (non-PHP) served independently of the main WordPress site.
- **Portainer (Bonus):** A powerful graphical administration interface used to monitor, manage, and inspect all running Docker containers, networks, and volumes.

## Starting and Stopping the Project
All management is handled via the provided `Makefile` at the root of the project.
- **To start everything:** Open your terminal in the project root and run `make`. 
- **To safely stop everything:** Run `make down`. This stops the services without deleting your data.

## Accessing the Web Services
- **Main Website:** Navigate to `https://himousta.42.fr`. (Your browser may warn you about a self-signed certificate; this is expected).
- **Administration Panel:** Navigate to `https://himousta.42.fr/wp-admin`. 
- **Static Website:** Accessible via the secondary port/route configured in NGINX.
- **Adminer & Portainer:** Accessible via their respective NGINX routes or exposed ports depending on the Docker Compose configuration.

## Locating and Managing Credentials
For security reasons, no passwords are hardcoded into the project files. 
- General configuration (usernames, database names, emails) is stored in the `.env` file located in `srcs/`.
- Sensitive passwords (database root password, FTP passwords, WordPress credentials) are stored in individual `.txt` files inside the `secrets/` folder at the root of the project. To change a password, modify the respective `.txt` file before running `make up`.

## Checking Service Health
To verify that all services are running correctly:
1. Open a terminal in the project root.
2. Run `docker compose -f srcs/docker-compose.yml ps`. This will list all running containers, including the bonus services, and their health status.