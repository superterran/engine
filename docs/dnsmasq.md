# dnsmasq

This is now installed by default on Fedora and hopefully other systems, and it provides a way to auto-map whatever.test to 127.0.0.1 so you do not have to edit your /etc/hosts file.

## Usage

Only tested on Fedora...

```
$ make dnsmasq 
```

This adds the entry and restarts the service, dns gods willing you should be able to start accessing .test domains config free.