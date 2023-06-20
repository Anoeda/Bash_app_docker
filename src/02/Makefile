ifndef VERBOSE
.SILENT:
endif


IMAGE_1 = "06_ubuntu_nginx:latest"
IMAGE_2 = "nginx:1.17.2-alpine"

CONTAINER_1_NAME = "ubuntu_nginx"
CONTAINER_2_NAME = "nginx"


all: clean build up open_URI



#	DOCKER-COMPOSE BUILD
build:
	docker-compose build

#	DOCKER-COMPOSE UP
up:
	docker-compose up -d

#	DOCKER-COMPOSE DOWN
down:
	docker-compose down



#	SHOW IMAGES AND CONTAINERS
show_all:
	echo ""
	docker images -a
	echo ""
	docker ps
	echo ""

#	OPEN LOCALHOST AND LOCALHOST/STATUS
open_URI:
	open -a "Google Chrome" http://localhost/ http://localhost/status



#	REMOVE CONTAINERS
clean:
	docker rm -f ${CONTAINER_1_NAME} ${CONTAINER_2_NAME}

#	REMOVE IMAGES AND CONTAINERS
fclean:
	docker rm -f ${CONTAINER_1_NAME} ${CONTAINER_2_NAME}
	docker rmi -f ${IMAGE_1} ${IMAGE_2}



.PHONY: all build up down show_all clean fclean
