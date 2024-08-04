FROM debian:oldstable

ARG WP_DATABASE
ARG WP_USER
ARG WP_PASSWORD

RUN apt update && apt upgrade -y && \
	apt install -y mariadb-server

RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chmod 755 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY ./tools/db_init.sh /tmp/db_init.sh

RUN chmod +x /tmp/db_init.sh && \
	bash /tmp/db_init.sh

ENTRYPOINT [ "mysqld_safe" ]