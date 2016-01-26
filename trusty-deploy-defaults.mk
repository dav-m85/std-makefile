REPLACE_VAR ?= CD
NGINX_ENABLED ?= /etc/nginx/sites-enabled
NGINX_AVAILABLE ?= /etc/nginx/sites-available
DIST ?= dist/nginx.conf
SERVER ?= default_server
# SECURE do not define this unless you want secure mode all the time.