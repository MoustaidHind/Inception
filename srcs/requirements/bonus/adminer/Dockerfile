FROM debian:bullseye

# 1. Install download tools and PHP processing tools
RUN apt-get update && apt-get install -y \
    wget \
    php7.4-fpm \
    php7.4-mysql

# 2. Create the folder to hold the single file
RUN mkdir -p /var/www/adminer

# 3. Download the exact Adminer file and rename it to index.php
RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O /var/www/adminer/index.php

# 4. Grant read/execute permissions
RUN chown -R www-data:www-data /var/www/adminer

# 5. Network Configuration: Force PHP to listen on Port 9000
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# 6. Create the hidden folder PHP needs to run without crashing
RUN mkdir -p /run/php

# 7. Keep the container alive by running PHP in the foreground
CMD ["php-fpm7.4", "-F"]