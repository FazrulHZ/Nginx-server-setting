server {
    server_name hamzah-dev.com www.hamzah-dev.com;
    charset utf-8;
    root    /home/ardin/skripsivuetify/dist;
    index   index.html index.htm;

    # Always serve index.html for any request
    location / {
        root /home/ardin/skripsivuetify/dist;
        try_files $uri /index.html;
    }
    error_log  /var/log/nginx/vue-app-error.log;
    access_log /var/log/nginx/vue-app-access.log;

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/hamzah-dev.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/hamzah-dev.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.hamzah-dev.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = hamzah-dev.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen      80;
    server_name hamzah-dev.com www.hamzah-dev.com;
    return 404; # managed by Certbot




}