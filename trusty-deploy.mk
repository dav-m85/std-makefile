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
# Deploy nginx host
#
std_deploy_nginx:
	cp $(DIST) $(NGINX_AVAILABLE)/$(NGINX_NAME)
ifdef SECURE
	echo "SECURE mode. Variable replacement hidden from logs for: $(REPLACE_VAR)"
	@$(foreach var,$(REPLACE_VAR),sed -i "s/__$(var)__/$(subst /,\/,$($(var)))/g" $(NGINX_AVAILABLE)/$(NGINX_NAME);)
else
	$(foreach var,$(REPLACE_VAR),sed -i "s/__$(var)__/$(subst /,\/,$($(var)))/g" $(NGINX_AVAILABLE)/$(NGINX_NAME);)
endif
	[ -e $(NGINX_ENABLED)/$(NGINX_NAME) ] || ln -s $(NGINX_AVAILABLE)/$(NGINX_NAME) $(NGINX_ENABLED)/$(NGINX_NAME)
	service nginx reload