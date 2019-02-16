# Engine

A simple little tool that allows for a nice feature-rich LEMP development environment.

[![Build Status](https://travis-ci.org/superterran/engine.svg?branch=master)](https://travis-ci.org/superterran/engine)

## Running...

```
$ make # help menu
$ make up # This will start the containers
$ make enable || make disable # for Fedora systems currently, will turn off legacy services and kick off the containers
```

## How-to

* clone new sites to /path/to/engine/sites/<site>
* start engine
* go to <type>.<site>.test

## Conventions

* Can be used with a basic understanding of docker
* easy wrapper tool that installs dependancies
* gives you a good consistant starting point, does not try to completely hold your hand
* developer-oriented

## Build Targets

* Windows 10 with WSL [Running Ubuntu](https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6?activetab=pivot:overviewtab)
* Ubuntu LTS
* Fedroa Latest
* Google ChromeOS 72+ running Crostini
* MacOS Latest

## External MySQL

If you symlink a socket file to ./mysql.sock, the docker composition will mount this into the container to `/mysql.sock`
and you will be able to leverage this with your app. The composition has a db service defined for use if you do not want
to manage your own mysql instance, further defining this support will come soon.

## 'External' sites not actually cloned in the sites/ dire

Best for this is to bind mount them to the location so docker can actually view the file, a symlink alone will not work.

```
$ sudo mount -o bind /home/me/repos/<codebase> <codebase>
```