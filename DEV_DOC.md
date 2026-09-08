# Developer Documentation

## Setting up the Environment from Scratch
To replicate this environment on a new machine:
1. **Prerequisites:** Ensure `docker`, `docker-compose`, and `make` are installed on the host OS.
2. **Domain Mapping:** Add `127.0.0.1 himousta.42.fr` to the host's `/etc/hosts` file.
3. **Data Directories:** The `Makefile` will attempt to create `/home/himousta/data/wordpress` and `/home/himousta/data/mariadb`. Ensure the host user has permissions for `/home/himousta/`.
4. **Secrets Configuration:** You must manually create the `secrets/` folder in the root directory. Inside it, use `echo -n "password" > filename.txt` to create the required secret files for both core and bonus services.

## Building and Launching (Makefile)
The `Makefile` acts as a wrapper for Docker Compose.
- `make build`: Only builds the Docker images based on the Dockerfiles in `srcs/requirements/` and `srcs/requirements/bonus/`.
- `make up`: Creates the networks, mounts the volumes, and boots the containers in detached mode (`-d`).
- `make all`: Combines the build and up commands.

## Managing Containers and Volumes
- **Stop containers:** `make down` (Executes `docker compose down`).
- **Clean unused resources:** `make clean` (Executes `docker system prune -f`).
- **Total Wipe:** `make fclean`. This command is destructive. It stops containers, deletes all images, forcefully removes Docker networks and volumes, and deletes the physical files in `/home/himousta/data/`. Use this to reset the project entirely.

## Data Storage, Persistence, and FTP Integration
All persistent data is stored outside of the container's ephemeral layer to ensure nothing is lost if a container crashes or gets rebuilt.
- **Mechanism:** The `docker-compose.yml` defines Named Volumes (like `wp_data` and `db_data`). Using the `local` driver and `bind` options, these volumes are mapped explicitly to the host machine.
- **Location:** 
  - Database files persist in `/home/himousta/data/mariadb`.
  - Website core files and themes persist in `/home/himousta/data/wordpress`.
- **FTP Integration:** The FTP container is configured to map directly to the `wp_data` volume. This allows an authenticated developer to use an FTP client (like FileZilla) to remotely upload, edit, and manage the live WordPress source code securely.