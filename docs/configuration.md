# Configuration

While it's not perfect, this tries to give you good flexibility over your environment and how it's configured.

## compose generation

docker-compose.yml is now generated automatically when building, this allows us to tune what containers
are running. All settings can be toggled through the .env in the root of the repo.

## .env file

This lets you customize paths and enable/disable parts of the system, such ad databases and php versions.

An example of the file...

```
SITESDIR=./var/sites
WEBPORT=80
MYSQLSOCK=./mysql.sock
CACHEGRINDDIR=./var/cachegrind

DB_ENABLE=0
DB_PORT=3306
DB_TYPE=mariadb
DB_DATA_DIR=./var/mysql

PHP56_ENABLE=1
PHP71_ENABLE=1
PHP72_ENABLE=1
```
