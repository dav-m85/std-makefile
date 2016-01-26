# WIP Deploy makefile for trusty target

## Usage

In your composer.json
```json
{
    "repositories": [
        {
            "type": "vcs",
            "url": "https://github.com/dav-m85/makefile-trusty"
        }
    ],
    "require": {
        "dav-m85/makefile-trusty":"dev-master"
    }
}
```

Then add the following makefile to your project
```makefile
# Deploy configuration variables
CD=$(shell pwd)

# Silent include, if we haven't called build yet
-include vendor/dav-m85/makefile-trusty/trusty-deploy.mk

# Standard targets
build:
    composer install

install: std_deploy_nginx
```

```make build && sudo make install``` shall now install nginx on your target machine.

## Available targets
Variables in **bold** can be found inside the makefiles. They have default values. You can override them by definind them before or after the inclusion.
Explore the **trust-deploy-defaults.mk** file to get the default values.
Each target's algorithm is described below step by step.

### std_deploy_nginx
* Copy **DIST** file to **NGINX_AVAILABLE** 
* Replace **REPLACE_VAR** variables in the copied file.
* Link it to a **NGINX_NAME** symlink inside of **NGINX_ENABLED**
* Reload the nginx server
