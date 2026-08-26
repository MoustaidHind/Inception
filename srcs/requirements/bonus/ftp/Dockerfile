FROM debian:bullseye

RUN apt update && apt install -y vsftpd

# create the secure workspace!
RUN mkdir -p /var/run/vsftpd/empty

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/ftp.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/ftp.sh

CMD ["ftp.sh"]