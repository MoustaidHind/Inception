NAME = inception
COMPOSE = ./srcs/docker-compose.yml
DATA_PATH = /home/$(USER)/data

all: build up

build:
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress
	docker compose -f $(COMPOSE) build

up:
	docker compose -f $(COMPOSE) up -d

down:
	docker compose -f $(COMPOSE) down

clean: down
	docker system prune -f

fclean: clean
	docker compose -f $(COMPOSE) down -v --rmi all
	sudo rm -rf $(DATA_PATH)
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	docker network rm $$(docker network ls -q) 2>/dev/null || true

re: fclean all

.PHONY: all build up down clean fclean re