# Engine 

A simple little tool that allows for a nice feature-rich LEMP development environment.

[![Build Status](https://travis-ci.org/superterran/engine.svg?branch=master)](https://travis-ci.org/superterran/engine)

Engine implements a multi-tennant web server so you can develop against and access all the sites at once. To accomplish this with a mix of sites across multiple platforms, it maintains multiple php-fpm instances running different versions. So a Magento 1 sites can run in the older php 5.6 while newer sites can run in php 7.1. This makes things a bit easier compared to solutions like valet. 

Engine is designed to work like a bare- metal solution, but it's really a docker composition with some tooling built around it.  Docker allows this to easily target multiple  dev environments, not to mention making it easy to support a broad range of site types.

## Usage

```
$ make install-bin # install global terminal command
$ engine || engine help # help menu
$ engine up # This will start the containers
$ engine enable | enable || make disable # for Fedora systems currently, will turn off legacy services and kick off the containers
$ engine bash php56 # get a terminal in the php56 container
$ engine tests # run all the unit tests
```

## Quick Start

* clone new sites to /path/to/engine/sites/<site>
* start engine
* go to type.site.test

