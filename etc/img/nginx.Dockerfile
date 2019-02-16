FROM nginx:latest

COPY ./etc/upstream/*.conf /etc/nginx/upstream.d/
COPY ./etc/types/*.conf /etc/nginx/types.d/
COPY ./var/nginx/*.conf /etc/nginx/sites-enabled/

COPY ./etc/conf/nginx.conf /etc/nginx/nginx.conf