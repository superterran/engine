# Engine

A simple little tool that allows for a nice feature-rich LEMP development environment.

## Running...

```
$ docker-compose.exe up --build
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


## External MySQL

If you symlink a socket file to ./mysql.sock, the docker composition will mount this into the container to `/mysql.sock`
and you will be able to leverage this with your app. The composition has a db service defined for use if you do not want
to manage your own mysql instance, further defining this support will come soon.