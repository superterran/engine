# Engine 

Provides for a nice feature-rich LEMP development environment. Supports PHP concurrency (5.6-7.2 currently), niceities like Visual Studio Code and Mailhog baked in, as well as the abiltiy to run side-by-side with other docker containers on 80 and 443 using jwilder/nginx-proxy. This all boils down to a well rounded, integrated web development experience that is widely compatible with _most_ web frameworks, but with an emphasis on PHP development. 

Engine requires docker, docker-compose and git pre-installed, all other dependancies are managed in docker.

[![Build Status](https://travis-ci.org/superterran/engine.svg?branch=master)](https://travis-ci.org/superterran/engine)

Engine implements a multi-tennant web server so you can develop against and access all the sites at once. To accomplish this with a mix of sites across multiple platforms, it maintains multiple php-fpm instances running different versions. So a Magento 1 sites can run in the older php 5.6 while newer sites can run in php 7.1. This makes things a bit easier compared to solutions like valet. 

Engine is designed to work like a bare-metal solution, but it's really it's tooling that generates docker compositions and helps you manage them in a way that's definately a lot easier than doing it manually. This project is designed to be cross-platform, already supporting Ubuntu, Fedora, ChromeOS (with crostini) and Windows. Mac support is underway but Engine is in-principal compatible. 

Engine doesn't require meta in your application's codebase, it doesn't require complicted setups, or in-depth knowledge about nginx or the rest of the stack. It's geared towards low configuration, simplicity, and getting out of your way so you can work.

## Usage

```console
$ engine # shows help
$ engine up # starts engine, at this point you should be operational!
$ engine bash php56 # get a terminal in the php56 container
$ engine tests # run all the unit tests
$ engine down # shuts it all off
```

## Installation

First, Install dependancies, `docker`, `docker-compose` and `git`. 

**NOTE** You may run into problems with the distro-provided version of docker, it's usually best to follow the official install instructions for your distro, i.e. https://docs.docker.com/install/linux/docker-ce/fedora/

### Quick Installation

First, make sure you have the proper dependancies, the installation will not continue without them. If you are installing in Windows WSL, it will detect `docker.exe` and `docker-compose.exe` and use these. 

Paste this into your terminal:

```console
bash <(curl https://raw.githubusercontent.com/superterran/engine/master/bin/installer)
```

### Manual Installation

Check the wiki for specfic platform instructions and gotchas, but basically install as follow:

1) Install dependancies, docker, docker-machine and git. You may run into problems with the distro-provided version of docker, it's usually best to follow the official install instructions for your distro, i.e. https://docs.docker.com/install/linux/docker-ce/fedora/

2) Clone down Engine, any path will work but I like to keep mine in home. e.g. `git clone https://github.com/superterran/engine.git ~/engine`

3) copy `.env.sample` to `.env` and edit to your liking

4) Install the engine binary, run `cd ~/engine && make install-bin`, this will allow you to run engine globally.

5) Let's peg ourselves to the currenet release for good measure `engine update` and press Y when prompted.

6) Finally, start engine to begin using it `engine up`.


## Quick Start

* Run through install steps
* clone new sites to `/path/to/engine/sites/site`, if you changed path in .env be sure to use the new path!
* `engine up` and ensure you have a hosts file entry if you aren't using dnsmasq
* go to `type.site.test` and check it out!

## Documentation

Check out the [GitHub Wiki](https://github.com/superterran/engine/wiki) for this project to see detailed usage documentation.
