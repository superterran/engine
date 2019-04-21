FROM python:3
RUN pip install jinja2

COPY ./etc/app/ /app/
COPY ./etc/ /app/etc/
COPY ./.env /.env
COPY ./var/ /app/var/

RUN echo $(cat /.env) >> /root/.bashrc
RUN exec bash