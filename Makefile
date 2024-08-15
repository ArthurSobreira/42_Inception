#------------------------------------------------------------------------------#
#                                  GENERICS                                    #
#------------------------------------------------------------------------------#

DEFAULT_GOAL: all
.DELETE_ON_ERROR: $(NAME)
.PHONY: all setup start down prune re

#------------------------------------------------------------------------------#
#                                VARIABLES                                     #
#------------------------------------------------------------------------------#

VOLUME_PATH		=	/home/arsobrei/data
WORDPRESS_PATH	=	$(VOLUME_PATH)/wordpress
MARIADB_PATH	=	$(VOLUME_PATH)/mariadb
HOST_FILE		=	/etc/hosts
COMPOSE_FILE	=	./src/docker-compose.yml

GREEN			=	"\033[32m"
RED				=	"\033[31m"
CYAN			=	"\033[36m"
YELLOW			=	"\033[33m"
LIMITER 		=	"\033[0m"

#------------------------------------------------------------------------------#
#                                 TARGETS                                      #
#------------------------------------------------------------------------------#

all: setup start

setup:
	@sudo chmod 666 $(HOST_FILE)
	@if ! grep -q 'arsobrei' $(HOST_FILE); then \
		echo $(GREEN)"Editing $(HOST_FILE) file..."$(LIMITER); \
		sudo sed -i '1i 127.0.0.1\tarsobrei.42.fr' $(HOST_FILE); \
	fi
	@if [ ! -d "$(WORDPRESS_PATH)" ]; then \
		echo $(GREEN)"Creating $(WORDPRESS_PATH) directory..."$(LIMITER); \
		sudo mkdir -p $(WORDPRESS_PATH); \
	fi
	@if [ ! -d "$(MARIADB_PATH)" ]; then \
		echo $(GREEN)"Creating $(MARIADB_PATH) directory..."$(LIMITER); \
		sudo mkdir -p $(MARIADB_PATH); \
	fi

start:
	@if [ -z "$$(docker-compose -f $(COMPOSE_FILE) ps 2> /dev/null | grep Up)" ]; then \
		echo $(CYAN)"Starting containers..."$(LIMITER); \
		docker-compose -f $(COMPOSE_FILE) up -d; \
	else \
		echo $(YELLOW)"Containers are already running..."$(LIMITER); \
	fi

down:
	@if [ -n "$$(docker-compose -f $(COMPOSE_FILE) images -q 2> /dev/null)" ]; then \
		echo $(RED)"Stopping containers..."$(LIMITER); \
		docker-compose -f $(COMPOSE_FILE) down; \
	else \
		echo $(YELLOW)"Containers are already down..."$(LIMITER); \
	fi

prune: down
	@if [ -n "$$(docker volume ls -q)" ]; then \
		echo $(RED)"Removing volumes..."$(LIMITER); \
		docker volume rm mariadb_volume wordpress_volume; \
	fi
	@if grep -q 'arsobrei' $(HOST_FILE); then \
		sudo sed -i '1d' $(HOST_FILE); \
	fi
	@sudo rm -fr $(VOLUME_PATH)/*
	@docker system prune -f -a

re: prune all