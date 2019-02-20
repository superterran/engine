FROM php:7.2-fpm

# Install cli-tools
COPY ./var/cli-tools/ /cli-tools-tmp
RUN rm /cli-tools-tmp/README.md 
RUN chmod +x /cli-tools-tmp/* 
RUN cp /cli-tools-tmp/* /usr/bin/