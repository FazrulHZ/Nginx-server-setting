server {
    server_name api.hamzah-dev.com;

    location / {
        proxy_set_header   X-Forwarded-For $remote_addr;
        proxy_set_header   Host $http_host;
        proxy_pass         http://localhost:3000;
    }
    
    client_max_body_size 10M;

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/api.hamzah-dev.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/api.hamzah-dev.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = api.hamzah-dev.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name api.hamzah-dev.com;
    return 404; # managed by Certbot


}
