.PHONY: help

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help
	@echo "Engine!"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

pull: ## Pull latest images
	docker-compose pull

down: ## Destroy containers
	docker-compose down -v

up: ## Re-create and start containers
	docker-compose down -v
	docker-compose up -d

stop: ## Stop containers
	docker-compose stop

start: ## Resume containers
	docker-compose start

bash: ## Connect to bash
	docker-compose run cli bash

enable: ## turns off the pre-existing dev stack on this fedora system and enables this tool
	sudo systemctl disable nginx
	sudo systemctl disable php70-php-fpm
	sudo systemctl disable php71-php-fpm
	sudo systemctl disable php-fpm
	make start

disable: ## urns on the pre-existing dev stack on this fedora system and disables this tool
	make stop
	sudo systemctl enable nginx
	sudo systemctl enable php70-php-fpm
	sudo systemctl enable php71-php-fpm
	sudo systemctl enable php-fpm