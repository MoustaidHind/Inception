FROM debian:bullseye
RUN apt update && apt install -y mariadb-server
COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/DataBase.sh /DataBase.sh
RUN chmod +x /DataBase.sh
CMD ["/DataBase.sh"] 
