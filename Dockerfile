FROM alpine:latest
MAINTAINER Tux Tong <huntthetux@gmail.com>

COPY build-nginx.sh /tmp/
COPY entry.sh /entry.sh

RUN chmod +x /tmp/build-nginx.sh && chmod +x /entry.sh && /tmp/build-nginx.sh

EXPOSE 80 443

ENTRYPOINT /entry.sh
