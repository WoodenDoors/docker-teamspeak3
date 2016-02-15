FROM debian:wheezy

MAINTAINER aheil

#ENV DEBIAN_FRONTEND noninteractive
ENV TS_VERSION LATEST

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install libnspr4 bzip2 spidermonkey-bin wget ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && wget -O /usr/bin/jsawk https://raw.githubusercontent.com/micha/jsawk/master/jsawk \
    && chmod +x /usr/bin/jsawk \
    && useradd -M -s /bin/false --uid 1000 teamspeak3 \
    && mkdir /data \
    && chown teamspeak3:teamspeak3 /data

ADD start-teamspeak3.sh /start-teamspeak3

EXPOSE 9987/udp 10011 30033

USER teamspeak3
VOLUME /data
WORKDIR /data
CMD ["/start-teamspeak3"]

