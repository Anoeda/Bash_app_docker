# syntax=docker/dockerfile:1.2

FROM ubuntu/nginx

# CIS-DI-0006
HEALTHCHECK CMD ["curl", "--fail", "http://localhost:80", "||", "exit 1"]

ARG USER="venicear:docker"
ARG UPDATE="apt-get update"
ARG INSTALL="apt-get install -y gcc spawn-fcgi libfcgi-dev"
ARG COMPILE="gcc server.c -l fcgi -o server"
ARG REMOVE_BIN="rm /bin/sh"
ARG MK_SYM_LINK="ln -s /bin/bash /bin/sh"
ARG CHOWN_USER="chown -R ${USER} /usr/share/nginx /var/run/nginx /var/tmp/nginx /var/log/nginx/ /etc/nginx/ /var/lib/nginx/ /tmp/"

WORKDIR /etc/nginx/

COPY entrypoint.sh server.c ./

RUN ${UPDATE} && ${INSTALL} && ${COMPILE} && ${REMOVE_BIN} && ${MK_SYM_LINK}
RUN --mount=type=secret,id=my_env source /run/secrets/my_env && ${PROVIDE_ACCESS_PERMISSIONS} && \
    ${ADD_GROUP} && ${ADD_USER} && ${MK_DIR_NGINX} && ${CHOWN_USER}

EXPOSE 81

ENTRYPOINT ["./entrypoint.sh"]

# CIS-DI-0001
USER ${USER}