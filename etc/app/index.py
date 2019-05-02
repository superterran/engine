#!/bin/python3
import os
import re
import glob

from jinja2 import Template

envre = re.compile(r'''^([^\s=]+)=(?:[\s"']*)(.+?)(?:[\s"']*)$''')
config = {}
with open('/.env') as ins:
    for line in ins:
        match = envre.match(line)
        if match is not None:
            config[match.group(1)] = match.group(2)

body = open('/app/etc/composition/head.yml.j2', 'r').read()

if config['IDE_ENABLE'] is "1":
    body += open('/app/etc/composition/ide.yml.j2', 'r').read()

if config['WEB_ENABLE'] is "1":
    body += open('/app/etc/composition/web.yml.j2', 'r').read()

if config['DB_ENABLE'] is "1":
    body += open('/app/etc/composition/db.yml.j2', 'r').read()

if config['ELASTICSEARCH_ENABLE'] is "1":
    body += open('/app/etc/composition/elasticsearch.yml.j2', 'r').read()

if config['SMTP_ENABLE'] is "1":
    body += open('/app/etc/composition/smtp.yml.j2', 'r').read()

for phpver in sorted(glob.glob('/app/etc/composition/php/*.yml.j2')):
    ver = re.search(r"php[0-9][0-9]", phpver).group()
    if ver.upper()+'_ENABLE' in config:
        if config[ver.upper()+'_ENABLE'] is "1":
            body += open(phpver, 'r').read()

t = Template(body)
print(t.render(config))

