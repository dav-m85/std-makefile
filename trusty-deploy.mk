# Ubuntu Trusty is the target here.
SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

# Include default values for variables
include $(SELF_DIR)trusty-deploy-defaults.mk

#
# Check if you got root access
#
is_sudo:
	echo Make sure i am sudo or fail

#
# nginx
#
std_deploy_nginx: std_install_nginx
	echo "std_deploy_nginx is deprecated, please use std_install_nginx instead"

std_install_nginx:
	@for F in `find $(NGINX_DIST) -type f -printf "%f\n"`; do \
		echo "Copying $$F"; \
		cp -- "$(NGINX_DIST)/$$F" "$(NGINX_AVAILABLE)/$(NGINX_PREFIX)$$F"; \
		[ -e $(NGINX_ENABLED)/$(NGINX_PREFIX)$$F ] || ln -s $(NGINX_AVAILABLE)/$(NGINX_PREFIX)$$F $(NGINX_ENABLED)/$(NGINX_PREFIX)$$F; \
	done;
	@for F in `find $(NGINX_DIST) -type f -printf "%f\n"`; do \
	  echo "Replacing $$F with: $(NGINX_REPLACE_VAR)"; \
	  $(foreach var,$(NGINX_REPLACE_VAR),sed -i "s/__$(var)__/$(subst /,\/,$($(var)))/g" $(NGINX_AVAILABLE)/$(NGINX_PREFIX)$$F;) \
	done;
	service nginx reload

std_clean_nginx:
	@for F in `find $(NGINX_DIST) -type f -printf "%f\n"`; do \
		echo "Removing $$F"; \
		rm "$(NGINX_ENABLED)/$(NGINX_PREFIX)$$F"; \
	done;
	service nginx reload

#
# supervisor
#
std_install_supervisor:
	@for F in `find $(SUPERVISOR_DIST) -type f -printf "%f\n"`; do \
		echo "Copying $$F"; \
		cp -- "$(SUPERVISOR_DIST)/$$F" "$(SUPERVISOR_D)/$(SUPERVISOR_PREFIX)$$F"; \
	done;
	@for F in `find $(SUPERVISOR_DIST) -type f -printf "%f\n"`; do \
	  echo "Replacing $$F with: $(SUPERVISOR_REPLACE_VAR)"; \
	  $(foreach var,$(SUPERVISOR_REPLACE_VAR),sed -i "s/__$(var)__/$(subst /,\/,$($(var)))/g" $(SUPERVISOR_D)/$(SUPERVISOR_PREFIX)$$F;) \
	done;
	service supervisor force-reload

std_clean_supervisor:
	@for F in `find $(SUPERVISOR_DIST) -type f -printf "%f\n"`; do \
		echo "Removing $$F"; \
		rm "$(SUPERVISOR_D)/$(SUPERVISOR_PREFIX)$$F"; \
	done;
	service supervisor force-reload

#
# cron
#
std_install_cron:
	@for F in `find $(CRON_DIST) -type f -printf "%f\n"`; do \
		echo "Copying $$F"; \
		cp -- "$(CRON_DIST)/$$F" "$(CRON_D)/$(CRON_PREFIX)$$F"; \
	done;
	@for F in `find $(CRON_DIST) -type f -printf "%f\n"`; do \
	  echo "Replacing $$F with: $(CRON_REPLACE_VAR)"; \
	  $(foreach var,$(CRON_REPLACE_VAR),sed -i "s/__$(var)__/$(subst /,\/,$($(var)))/g" $(CRON_D)/$(CRON_PREFIX)$$F;) \
	done;
	service cron restart

std_clean_cron:
	@for F in `find $(CRON_DIST) -type f -printf "%f\n"`; do \
		echo "Removing $$F"; \
		rm "$(CRON_D)/$(CRON_PREFIX)$$F"; \
	done;
	service cron restart