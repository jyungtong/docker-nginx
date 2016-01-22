#! /bin/sh

export NGINX_VERSION=1.9.9
export NGINX_FLAGS="--user=nginx      \
--group=nginx                         \
--prefix=/etc/nginx                   \
--sbin-path=/usr/sbin/nginx           \
--conf-path=/etc/nginx/nginx.conf     \
--pid-path=/var/run/nginx.pid         \
--lock-path=/var/run/nginx.lock       \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_gzip_static_module        \
--with-http_stub_status_module        \
--with-http_ssl_module                \
--with-pcre                           \
--with-file-aio                       \
--with-http_realip_module             \
--without-http_scgi_module            \
--without-http_uwsgi_module           \
--without-http_fastcgi_module"

apk --update --no-cache add gcc g++ make curl pcre pcre-dev zlib-dev openssl-dev linux-headers && \
  cd /tmp/ && \
  curl -SLo- http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar xz && \
  cd nginx-${NGINX_VERSION} && ./configure ${NGINX_FLAGS} && \
  make -j`grep -c ^processor /proc/cpuinfo` && make install && \
  addgroup nginx && adduser -D -H -Gnginx nginx && \
  apk del gcc g++ make curl pcre-dev zlib-dev openssl-dev linux-headers && \
  cd / && rm -rf /var/cache/apk/* /tmp/*
