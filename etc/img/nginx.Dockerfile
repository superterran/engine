FROM nginx:latest
COPY ./etc/types/*.conf /etc/nginx/conf.d/
COPY ./etc/upstream/*.conf /etc/nginx/conf.d/