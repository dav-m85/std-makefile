# Rule for installing a dist file for nginx conf
NGINX_ENABLED=/etc/nginx/sites-enabled
NGINX_AVAILABLE=/etc/nginx/sites-available
DIST=dist/nginx.conf

$(NGINX_ENABLED)/%.conf:
	cp $(DIST) $(NGINX_AVAILABLE)/$(notdir $@)
	$(foreach var,$(REPLACE_VAR),sed -i "s/__$(var)__/$(subst /,\/,$($(var)))/g" $(NGINX_AVAILABLE)/$(notdir $@);)
	ln -s $(NGINX_AVAILABLE)/$(notdir $@) $@
	service nginx reload

is_sudo:
	echo Make sure i am sudo or fail
