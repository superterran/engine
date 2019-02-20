FROM php:7.2-fpm

# Install cli-tools
COPY ./var/cli-tools/ /cli-tools-tmp
RUN chmod +x /cli-tools-tmp/* 
RUN touch /cli-tools-tmp/superterran-engine-ignore
RUN rm /cli-tools-tmp/README.md
RUN @cp /cli-tools-tmp/* /usr/bin/