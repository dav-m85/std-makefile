ENV ?=

NGINX_PREFIX ?= $(ENV)
NGINX_DIST ?= dist/nginx
NGINX_ENABLED ?= /etc/nginx/sites-enabled
NGINX_AVAILABLE ?= /etc/nginx/sites-available
NGINX_REPLACE_VAR ?= CD NGINX_PREFIX

SUPERVISOR_PREFIX ?= $(ENV)
SUPERVISOR_DIST ?= dist/supervisor
SUPERVISOR_D ?= /etc/supervisor/conf.d
SUPERVISOR_REPLACE_VAR ?= CD SUPERVISOR_PREFIX

CRON_PREFIX ?= $(ENV)
CRON_DIST ?= dist/cron
CRON_D ?= /etc/cron.d
CRON_REPLACE_VAR ?= CD CRON_PREFIX
