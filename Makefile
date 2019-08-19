DOCKEREXE=
ifneq ($(UNAME), Linux)
    DOCKEREXE :=.exe
endif

.PHONY: help

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

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
	if [ -a /usr/local/bin/engine ]; then sudo unlink /usr/local/bin/engine; fi;
