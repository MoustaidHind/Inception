#!/bin/bash

DB_ROOT_PASS=$(cat /run/secrets/db_root_password)
DB_PASS=$(cat /run/secrets/db_password)

service mariadb start

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${DB_PASS}';"
mariadb -e "GRANT ALL PRIVILEGES ON  \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
mariadb -e "FLUSH PRIVILEGES;"

# 5. Shut down the temporary background server using the new root password
mysqladmin -u root -p"${DB_ROOT_PASS}" shutdown

exec mysqld_safe