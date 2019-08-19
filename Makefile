DOCKEREXE=
ifneq ($(UNAME), Linux)
    DOCKEREXE :=.exe
endif

.PHONY: help

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

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

bin-install: bin-uninstall ## installs engine bin cmd to /usr/bin/local
	sudo ln -s "$$(pwd)/bin/engine" /usr/local/bin/engine
	sudo chmod +x /usr/local/bin/engine

bin-uninstall: ## removes engine cmd from /usr/bin/local
	sudo unlink /usr/local/bin/engine

snapcraft: ## executes snapcraft and generates a snap
	sudo docker run -v $$(pwd):/my-snap snapcore/snapcraft sh -c "apt update && cd /my-snap && snapcraft"

