VOLUME_PATH=/home/arsobrei/data
COMPOSE=/home/user42/Projects/42_inception/src/docker-compose.yml

all: setup start

setup:
	@sudo chmod 666 /etc/hosts
	@if ! grep -q 'arsobrei' /etc/hosts; then \
		sudo echo '127.0.0.1	arsobrei.42.fr' >> /etc/hosts; \
	fi
	@if [ ! -d "${VOLUME_PATH}/wordpress" ]; then \
		sudo mkdir -p ${VOLUME_PATH}/wordpress; \
	fi
	@if [ ! -d "${VOLUME_PATH}/mariadb" ]; then \
		sudo mkdir -p ${VOLUME_PATH}/mariadb; \
	fi

start:
	@if [ -z "$$(docker-compose -f ${COMPOSE} ps 2> /dev/null | grep Up)" ]; then \
		docker-compose -f ${COMPOSE} up; \
	else \
		echo "There is containers up, please KILL them :)"; \
	fi

down:
	@if [ -n "$$(docker-compose -f ${COMPOSE} images -q 2> /dev/null)" ]; then \
		docker-compose -f ${COMPOSE} down; \
	else \
		echo "No images to delete!"; \
	fi

prune: down
	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume rm $(shell docker volume ls -q); \
	fi
	@sudo rm -fr ${VOLUME_PATH}/*
	@docker system prune -f -a

re: prune all

.PHONY: all setup start down prune re