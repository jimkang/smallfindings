include config.mk

HOMEDIR = $(shell pwd)

build:
	npx @11ty/eleventy \
    --config=eleventy-config.js

pushall: sync
	git push origin master

sync:
	s3cmd sync --acl-public _site/ s3://$(BUCKET)/$(APPDIR)/
