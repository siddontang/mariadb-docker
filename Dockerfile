FROM ubuntu:14.04
MAINTAINER siddontang@gmail.com

# Use Chinese sources.list, maybe
COPY sources.list /etc/apt/sources.list

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
    echo 'deb http://mirrors.syringanetworks.net/mariadb/repo/10.1/ubuntu trusty main' >> /etc/apt/sources.list && \
    echo 'deb-src http://mirrors.syringanetworks.net/mariadb/repo/10.1/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/mysql/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY my.cnf /etc/mysql/my.cnf
COPY my-default.cnf /usr/share/mysql/my-default.cnf

COPY start.sh /start.sh
RUN chmod +x /start.sh

VOLUME ["/etc/mysql", "/var/lib/mysql"]

# Avoid container connect error "TERM environment variable not set"
ENV TERM dumb

EXPOSE 3306

CMD ["/start.sh"]
