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

Then add the following makefile
```makefile
REPLACE_VAR=CD DOMAIN

CD=$(shell pwd)
DOMAIN=default_server

include vendor/dav-m85/makefile-trusty/makefile

install: | is_sudo /etc/nginx/sites-enabled/website.conf
```

```sudo make install``` shall now install nginx on your target machine.
