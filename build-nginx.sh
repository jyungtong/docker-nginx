#! /bin/sh

export NGINX_VERSION=1.9.9
export NGINX_FLAGS="--user=nginx          \
--group=nginx                             \
--prefix=/etc/nginx                       \
--sbin-path=/usr/sbin/nginx               \
--conf-path=/etc/nginx/nginx.conf         \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/run/nginx.pid             \
--lock-path=/var/run/nginx.lock           \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
--with-http_ssl_module          \
--with-http_realip_module       \
--with-http_addition_module     \
--with-http_sub_module          \
--with-http_dav_module          \
--with-http_flv_module          \
--with-http_mp4_module          \
--with-http_gunzip_module       \
--with-http_gzip_static_module  \
--with-http_random_index_module \
--with-http_secure_link_module  \
--with-http_stub_status_module  \
--with-http_auth_request_module \
--with-threads                  \
--with-stream                   \
--with-stream_ssl_module        \
--with-http_slice_module        \
--with-mail                     \
--with-mail_ssl_module          \
--with-file-aio                 \
--with-http_v2_module           \
--with-ipv6                     \
--with-pcre"

apk --update --no-cache add gcc g++ make curl pcre pcre-dev zlib-dev openssl-dev linux-headers && \
  cd /tmp/ && \
  curl -SLo- http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar xz && \
  cd nginx-${NGINX_VERSION} && ./configure ${NGINX_FLAGS} && \
  make -j`grep -c ^processor /proc/cpuinfo` && make install && \
  addgroup nginx && adduser -D -H -Gnginx nginx && \
  apk del gcc g++ make curl pcre-dev zlib-dev openssl-dev linux-headers && \
  cd / && rm -rf /var/cache/apk/* /tmp/*
