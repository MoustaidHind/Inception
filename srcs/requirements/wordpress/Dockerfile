FROM debian:bullseye
RUN apt update && apt install -y php-fpm php-mysql wget 
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp-cli

COPY conf/wordpress.conf /etc/php/7.4/fpm/pool.d/wordpress.conf

COPY tools/wp.sh /wp.sh
RUN chmod +x /wp.sh

CMD ["/wp.sh"]
