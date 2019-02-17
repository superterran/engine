#!/bin/python3
import os
from jinja2 import Template

t = Template("Hello {{ something }}!")
print(t.render(something="World"))


print(os.environ['SITESDIR'])