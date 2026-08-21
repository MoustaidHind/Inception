COMPOSE_FILE = ./srcs/docker-compose.yml

all: up

up:
	docker-compose -f $(COMPOSE_FILE) up -d --build

down:
	docker-compose -f $(COMPOSE_FILE) down

stop: 
	docker-compose -f $(COMPOSE_FILE) stop

start: 
	docker-compose -f $(COMPOSE_FILE) start

status: 
	docker ps


clean: down
	docker system prune -af

fclean: clean
	sudo rm -rf /home/hmoustaid/data/mariadb
	sudo rm -rf /home/hmoustaid/data/wordpress
	docker volume prune -f
	docker network prune -f

re: fclean all

.PHONY: all up down stop start status clean fclean re