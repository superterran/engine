FROM python:3

COPY ./etc/app/ /app/
COPY ./etc/ /app/etc/
COPY ./.env /.env

RUN echo $(cat /.env) >> /root/.bashrc
RUN exec bash
RUN pip install jinja2