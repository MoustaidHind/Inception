#!/bin/bash

service mariadb start

sleep 3

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON  \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

mysqladmin -u root shutdown

exec mysqld_safe


# 1. Turn on the database in the background so we can configure it
# Give it a couple of seconds to fully wake up
# 2. Run the SQL commands using the secret Environment Variables
# 3. Shut down the background service cleanly
# 4. Turn the database back on in the FOREGROUND so the container stays alive
