include config.mk

HOMEDIR = $(shell pwd)
SSHCMD = ssh $(USER)@$(SERVER)
APPDIR = /usr/share/nginx/html/smidgeo.com/bots

build:
	npx @11ty/eleventy \
    --config=eleventy-config.js

pushall: sync
	git push origin master

sync:
	scp app.css $(USER)@$(SERVER):$(APPDIR)
	scp index.html $(USER)@$(SERVER):$(APPDIR)
	rsync -a media $(USER)@$(SERVER):$(APPDIR)

prettier:
	prettier --single-quote --write "**/*.js"
