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
body = ""


earliest = 0

for phpver in sorted(glob.glob('/app/etc/composition/php/*.yml.j2')):
    ver = re.search(r"php[0-9][0-9]", phpver).group()
    if ver.upper()+'_ENABLE' in config:
        if earliest is 0: 
            earliest = ver.lower()
        latest = ver.lower()
        if config[ver.upper()+'_ENABLE'] is "1":
            body +="" #body += "#   set $"+ver.lower()+" \"true\";\n"

# body += "\n   set $PHP_EARLIEST \""+earliest+"\";\n"
# body += "   set $PHP_LATEST \""+latest+"\";\n"

body += "\n"


body += "map $sname $phpver { \n"

body += "   default     auto;\n"
for key,val in config.items():
    if "PHP_" in key:
        body += "   "+key.replace('PHP_','')+"  "+val+";\n"

body += "}\n\n"

body += "map $type $phpverdefault { \n"

body += "   default     "+latest+";\n"
for key,val in config.items():
    if "TYPE_" in key:
        body += "   "+key.replace('TYPE_','').lower()+"  "+val+";\n"

body += "}\n"




t = Template(body)
print(t.render(config))

