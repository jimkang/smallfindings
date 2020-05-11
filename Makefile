include config.mk

HOMEDIR = $(shell pwd)

build:
	npx @11ty/eleventy \
    --config=eleventy-config.js \
    --output=smallfindings

pushall: sync
	git push origin master

sync:
	s3cmd sync --acl-public smallfindings/ s3://$(BUCKET)/$(APPDIR)/

episode-2:
	./prepare-audio.sh src-audio/episode-2
	cd src-audio/episode-2 && \
  rm episode-2.wav && \
	sox e2-cold-open.wav \
    theme-high.wav \
    e2-intro.wav \
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
    e2-food.wav \
    theme-high.wav \
    e2-wily.wav \
    theme-low.wav \
    episode-2.wav
	lame src-audio/episode-2/episode-2.wav episodes/smallfindings-2-still-eruption-columns.mp3 \
    --tt "Small Findings Episode 2: Still Eruption Columns" \
    --ta "Jim Kang" \
    --ty 2020

episode-3:
	#./prepare-audio.sh src-audio/episode-3
	cd src-audio/episode-3 && \
	sox \
    ../common/theme-high.wav \
    e3-intro.wav \
    ../common/theme-high.wav \
    e3-china.wav \
    ../common/theme-high.wav \
    e3-harvard.wav \
    ../common/theme-piano.wav \
    e3-icus.wav \
    ../common/theme-piano.wav \
    e3-conspiracy-theories.wav \
    ../common/theme-piano.wav \
    e3-volcanic-lightning.wav \
    when-theres-lightning.wav \
    ../common/theme-high.wav \
    e3-space-elevator.wav \
    ../common/theme-high.wav \
    e3-closing.wav \
    ../common/theme-low.wav \
    episode-3.wav
	lame src-audio/episode-3/episode-3.wav episodes/smallfindings-3-when-theres-lightning.mp3 \
    --tt "Small Findings Episode 3: When There's Lightning" \
    --ta "Jim Kang" \
    --ty 2020

episode-4:
	#./prepare-audio.sh src-audio/episode-4
	cd src-audio/episode-4 && \
	sox \
    ../common/theme-high.wav \
    e4-intro.wav \
    ../common/theme-high.wav \
    e4-pizza-deployment.wav \
    ../common/theme-high.wav \
    e4-stock-buybacks.wav \
    ../common/theme-piano.wav \
    e4-amazon-and-labor.wav \
    ../common/theme-high.wav \
    e4-testament.wav \
    night-of-the-witch-sample.wav \
    e4-existential-risk.wav \
    ../common/theme-high.wav \
    e4-closing.wav \
    ../common/theme-low.wav \
    episode-4.wav
	lame src-audio/episode-4/episode-4.wav episodes/smallfindings-4-theres-gotta-be-a-better-way.mp3 \
    --tt "Small Findings Episode 4: There's gotta be a better way" \
    --ta "Jim Kang" \
    --ty 2020

episode-5:
	./prepare-audio.sh src-audio/episode-5
	cd src-audio/episode-5 && \
	sox \
    theme-anderson.wav \
    ../common/theme-high.wav \
    e5-intro.wav \
    ../common/theme-high.wav \
    e5-paynes-gray.wav \
    ../common/theme-high.wav \
    e5-witch-of-endor.wav \
    ../common/theme-high.wav \
    e5-surprising-cambridge-businesses.wav \
    ../common/theme-piano.wav \
    e5-magnetars.wav \
    ../common/theme-high.wav \
    e5-cdns.wav \
    e5-cdn-postscript.wav \
    ../common/theme-high.wav \
    e5-thing-at-end-of-faucet.wav \
    ../common/theme-high.wav \
    e5-closing.wav \
    ../common/theme-low.wav \
    episode-5.wav
	lame src-audio/episode-5/episode-5.wav episodes/smallfindings-5-the-devils-ghost.mp3 \
    --tt "Small Findings Episode 5: The Devil's Ghost" \
    --ta "Jim Kang" \
    --ty 2020
