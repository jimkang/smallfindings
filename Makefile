include config.mk

HOMEDIR = $(shell pwd)

build:
	npx @11ty/eleventy \
    --config=eleventy-config.js

pushall: sync
	git push origin master

sync:
	s3cmd sync --acl-public _site/ s3://$(BUCKET)/$(APPDIR)/

episode-2:
	cd src-audio/episode-2 && \
    ./prepare-audio.sh
	cd src-audio/episode-2 && \
  rm episode-2.wav && \
	sox e2-cold-open.wav \
    theme-high.wav \
    e2-intro.wav \
    theme-high.wav \
    e2-volcano-1.wav \
    e2-volcano-2.wav \
    theme-high.wav \
    e2-sleep-1.wav \
    theme-high.wav \
    e2-sleep-2.wav \
    theme-high.wav \
    e2-food.wav \
    theme-high.wav \
    e2-signing-statement.wav \
    theme-high.wav \
    e2-art.wav \
    theme-high.wav \
    e2-zoom.wav \
    theme-high.wav \
    e2-audm.wav \
    theme-high.wav \
    e2-wistia.wav \
    theme-high.wav \
    e2-ads.wav \
    theme-high.wav \
    e2-wily.wav \
    theme-low.wav \
    episode-2.wav
	lame src-audio/episode-2/episode-2.wav episodes/smallfindings-2-still-eruption-columns.mp3 \
    --tt "Small Findings Episode 2: Still Eruption Columns" \
    --ta "Jim Kang" \
    --ty 2020
