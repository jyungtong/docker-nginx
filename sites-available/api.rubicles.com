upstream blog_app {
  server rubiclesblogapp:3001;
}

upstream auth_app {
  server rubiclesauthapp:3002;
}

server {
  #listen [::]:80;
  listen 80;

  server_name api.rubicles.com;

  #root /sites/rubicles.com;

  charset utf-8;

  # Custom 404 page
  error_page 404 /404.html;

  # Include the basic h5bp config set
  include h5bp/basic.conf;

  location /api/authenticate {
    proxy_set_header   Host  $http_host;
    proxy_set_header   Connection "";
    proxy_pass         http://auth_app;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
  }

  location /api/users {
    proxy_set_header   Host  $http_host;
    proxy_set_header   Connection "";
    proxy_pass         http://auth_app;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
  }

  location /api/articles {
    proxy_set_header   Host  $http_host;
    proxy_set_header   Connection "";
    proxy_pass         http://blog_app;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
  }
}
