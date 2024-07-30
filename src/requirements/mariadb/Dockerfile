FROM debian:oldstable

RUN apt update && apt upgrade -y && \
	apt install -y mariadb-server

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY ./tools/db_init.sh /tmp/db_init.sh

RUN chmod 755 /tmp/db_init.sh && \
	/tmp/db_init.sh

ENTRYPOINT [ "mysqld_safe" ]