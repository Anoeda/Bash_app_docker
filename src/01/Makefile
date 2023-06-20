# export DOCKER_BUILDKIT=1

ifndef VERBOSE
.SILENT:
endif

RM = rm -rf

IMAGE_NAME = "ubuntu/nginx"
IMAGE_TAG  = "version_1.0"
IMAGE      = ${IMAGE_NAME}:${IMAGE_TAG}

CONTAINER_NAME = "nginx_fast_cgi"

LOCAL_PORT  = 80
DOCKER_PORT = 81

NGINX_WORKDIR          = "/etc/nginx"
ENTRYPOINT_NAME        = "entrypoint.sh"
SECRET_DOCKER_ENV_NAME = ".env"
DOCKLEIGNORE_NAME      = ".dockleignore"


#	CREATE AN IMAGE AND RUN A CONTAINER
all: clean create_entrypoint_script create_secret_docker_env_file create_dockleignore_file \
	 build_image run_container 															   \
	 show_all open_URI dockle_check                 									   \

rebuild: clean all



#	BUILD IMAGE
build_image:
	docker build -t ${IMAGE} --secret id=my_env,src=.env .

#	RUN CONTAINER
run_container:
	docker run -d -p ${LOCAL_PORT}:${DOCKER_PORT} -v /$(shell pwd)/nginx.conf:/etc/nginx/nginx.conf --name ${CONTAINER_NAME} ${IMAGE}



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



#	CREATE A SCRIPT FOR DOCKERFILE ENTRYPOINT
create_entrypoint_script:
	echo "#!/bin/bash\n\n\
chmod +x ${ENTRYPOINT_NAME}\n\
spawn-fcgi -p 8080 -f ${NGINX_WORKDIR}/server\n\
nginx -s reload\n\
nginx -g 'daemon off;'" > ${ENTRYPOINT_NAME}

remove_entrypoint_script:
	${RM} ${ENTRYPOINT_NAME}



#	CREATE SECRET DOCKER ENV FILE WITH DOCKERFILE ARGS
create_secret_docker_env_file:
	echo "PROVIDE_ACCESS_PERMISSIONS='chmod +x entrypoint.sh'\n\
ADD_GROUP='groupadd docker'\n\
ADD_USER='useradd venicear -g docker'\n\
MK_DIR_NGINX='mkdir -p /var/run/nginx /var/tmp/nginx'" > ${SECRET_DOCKER_ENV_NAME}

remove_secret_docker_env_file:
	${RM} ${SECRET_DOCKER_ENV_NAME}



#	DOCKLE CHECK
dockle_check:
	dockle ${IMAGE}
	echo "Dockle check is done\n"
	
#	CREATE A DOCKLEIGNORE FILE
create_dockleignore_file:
	echo "# Enable Content trust for Docker\n\
CIS-DI-0005\n\n\
# Confirm safety of setuid/setgid files\n\
CIS-DI-0008" > ${DOCKLEIGNORE_NAME}

remove_dockleignore_file:
	${RM} ${DOCKLEIGNORE_NAME}



#	REMOVE IMAGE AND CONTAINER
clean:
	docker rm -f ${CONTAINER_NAME}
	docker rmi -f ${IMAGE}

fclean: clean
	${RM} ${ENTRYPOINT_NAME}
	${RM} ${SECRET_DOCKER_ENV_NAME}
	${RM} ${DOCKLEIGNORE_NAME}



.PHONY: all rebuild build_image run_container show_all open_URI create_entrypoint_script remove_entrypoint_script \
create_secret_docker_env_file remove_secret_docker_env_file clean fclean