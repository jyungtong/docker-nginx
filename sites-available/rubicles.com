upstream rcdemo {
  server rcdemoapi:3000;
}

server {
  #listen [::]:80;
  listen 80;

  # listen on the www host
  server_name www.rubicles.com;

  return 301 $scheme://rubicles.com$request_uri;
}

server {
  #listen [::]:80;
  listen 80;

  server_name rubicles.com;

  root /sites/rubicles.com;

  charset utf-8;

  # Custom 404 page
  error_page 404 /404.html;

  # Include the basic h5bp config set
  include h5bp/basic.conf;

  location /demo/api {
    proxy_set_header   Host  $http_host;
    proxy_set_header   Connection "";
    proxy_pass         http://rcdemo;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
  }
}
