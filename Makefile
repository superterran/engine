DOCKEREXE=
ifneq ($(UNAME), Linux)
    DOCKEREXE :=.exe
endif

.PHONY: help

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

log: ## Tail the composition logs
	docker-compose${DOCKEREXE} logs -f

down: ## Destroy containers
	docker-compose${DOCKEREXE} down -v

up: down config ## down and re-up containers
	docker-compose${DOCKEREXE} up -d

build: config ## builds current images
	docker-compose${DOCKEREXE} build --no-cache

stop: ## Stop containers
	docker-compose${DOCKEREXE} stop

start: config ## Resume containers
	docker-compose${DOCKEREXE} start

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

dnsmasq-install: ## adds the dnsmasq entry for .test, a restart may be required!
	sudo cp ./etc/conf/dnsmasq.conf /etc/dnsmasq.d/superterran-engine.conf
	sudo systemctl restart dnsmasq

dnsmasq-uninstall: ## removes the dnsmasq entry for .test, a restart may be required!
	sudo rm /etc/dnsmasq.d/superterran-engine.conf
	sudo systemctl restart dnsmasq

test: build up ## runs the full test suite
	bin/tests

config: config-build ## generates the docker composition
	docker${DOCKEREXE} run engine-config:latest python -- /app/index.py > docker-compose.yml
config-bash: ## gives you a bash terminal for the config image
	docker${DOCKEREXE} run -it engine-config:latest bash
config-build: ## builds the config image
	docker${DOCKEREXE} build ./ -f etc/img/config.Dockerfile -t engine-config:latest --no-cache

bin-install: bin-uninstall ## installs engine bin cmd to /usr/bin/local
	sudo ln -s "$$(pwd)/bin/engine" /usr/local/bin/engine
	sudo chmod +x /usr/local/bin/engine

bin-uninstall: ## removes engine cmd from /usr/bin/local
	sudo unlink /usr/local/bin/engine

nginx-reload: config-build ## reloads nginx, refreshing configs and whatnot
	docker-compose${DOCKEREXE} build --no-cache web
	make up

download-cli-tools: ## downloads cli tools for system images
	bin/download-cli-tools