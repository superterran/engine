.PHONY: help

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help
	@echo "Engine!"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

log: ## Tail the composition logs
	docker-compose logs -f

down: ## Destroy containers
	docker-compose down -v

up: down ## down and re-up containers
	docker-compose up -d

build: down ## builds current images and ups the containers
	docker-compose build --no-cache

stop: ## Stop containers
	docker-compose stop

start: ## Resume containers
	docker-compose start

enable: ## turns off the pre-existing dev stack on this fedora system and enables this tool
	sudo systemctl disable nginx
	sudo systemctl stop nginx

	# sudo systemctl disable mariadb
	# sudo systemctl stop mariadb

	sudo systemctl disable php70-php-fpm
	sudo systemctl stop php70-php-fpm

	sudo systemctl disable php71-php-fpm
	sudo systemctl stop php71-php-fpm

	sudo systemctl disable php-fpm
	sudo systemctl stop php-fpm

	make up

disable: down ## urns on the pre-existing dev stack on this fedora system and disables this tool
	sudo systemctl enable nginx
	sudo systemctl start nginx

	# sudo systemctl enable mariadb
	# sudo systemctl start mariadb

	sudo systemctl enable php70-php-fpm
	sudo systemctl start php70-php-fpm

	sudo systemctl enable php71-php-fpm
	sudo systemctl start php71-php-fpm

	sudo systemctl enable php-fpm
	sudo systemctl start php-fpm

dnsmasq: ## adds the dnsmasq entry for .test, a restart may be required!
	sudo cp ./etc/conf/dnsmasq.conf /etc/dnsmasq.d/superterran-engine.conf
	sudo systemctl restart dnsmasq

dnsmasq-rm: ## removes the dnsmasq entry for .test, a restart may be required!
	sudo rm /etc/dnsmasq.d/superterran-engine.conf
	sudo systemctl restart dnsmasq

test: build up ## runs the full test suite
	bin/tests

config: config-build ## generates the docker composition
	bin/docker-run
config-bash: ## gives you a bash terminal for the config image
	docker run -it engine-config:latest bash

config-build: ## builds the config image
	docker build ./ -f etc/img/config.Dockerfile -t engine-config:latest