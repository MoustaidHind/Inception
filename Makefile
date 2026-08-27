COMPOSE_FILE = srcs/docker-compose.yml

all: up

up:
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down

stop: 
	docker compose -f $(COMPOSE_FILE) stop

start: 
	docker compose -f $(COMPOSE_FILE) start

status: 
	docker ps


clean: down
	docker system prune -af

# not the right path to delete the data volumes.
fclean: clean
	sudo rm -rf /home/hmoustaid/data/mariadb 
	sudo rm -rf /home/hmoustaid/data/wordpress
	docker volume prune -f
	docker network prune -f

re: fclean all

.PHONY: all up down stop start status clean fclean re


# NAME = inception
# COMPOSE = ./srcs/docker-compose.yml
# DATA_PATH = /home/himousta/data

# all: build up

# build:
# 	mkdir -p $(DATA_PATH)/mariadb
# 	mkdir -p $(DATA_PATH)/wordpress
# 	docker compose -f $(COMPOSE) build

# up:
# 	docker compose -f $(COMPOSE) up -d

# down:
# 	docker compose -f $(COMPOSE) down

# clean: down
# 	docker system prune -f

# fclean: clean
# 	docker compose -f $(COMPOSE) down -v --rmi all
# 	sudo rm -rf $(DATA_PATH)/mariadb/*
# 	sudo rm -rf $(DATA_PATH)/wordpress/*
# 	docker volume rm $$(docker volume ls -q) || true
# 	docker network rm $$(docker network ls -q) 2>/dev/null || true

# re: fclean all

# .PHONY: all build up down clean fclean re