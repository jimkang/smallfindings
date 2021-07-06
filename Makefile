include config.mk

HOMEDIR = $(shell pwd)

build:
	npx @11ty/eleventy \
    --config=eleventy-config.js \
    --output=smallfindings

serve:
	npx @11ty/eleventy \
    --config=eleventy-config.js \
    --output=smallfindings \
    --serve

pushall: sync
	git push origin master

sync:
	s3cmd sync --acl-public smallfindings/ s3://$(BUCKET)/$(APPDIR)/

back-up:
	rsync -a $(HOMEDIR)/ $(USER)@$(SERVER):$(BACKUPROOT)/$(APPDIR) \
		--exclude .git \
    --omit-dir-times \
    --no-perms

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

episode-6:
	#./prepare-audio.sh src-audio/episode-6
	cd src-audio/episode-6 && \
	sox \
    e6-dr-wily-start.wav \
    ../common/theme-high.wav \
    e6-intro.wav \
    ../common/theme-high.wav \
    e6-pizza-parchment-paper.wav \
    ../common/theme-high.wav \
    e6-delivery-services.wav \
    ../common/theme-piano.wav \
    e6-pasquallys.wav \
    ../common/theme-high.wav \
    e6-puff-functionality.wav \
    ../episode-3/when-theres-lightning.wav \
    e6-closing.wav \
    ../common/theme-low.wav \
    e6-epilogue.wav \
    episode-6.wav
	lame src-audio/episode-6/episode-6.wav episodes/smallfindings-6-reevaluating-dirrty-puff.mp3 \
    --tt "Small Findings Episode 6: Reevaluating Dirrty Puff" \
    --ta "Jim Kang" \
    --ty 2020

episode-7:
	./prepare-audio.sh src-audio/episode-7
	cd src-audio/episode-7 && \
	sox \
    ../common/theme-high.wav \
    e7-intro.wav \
    ../common/theme-high.wav \
    e7-gravitational-lensing.wav \
    ../common/theme-high.wav \
    e7-lotr-tone-a.wav \
    e7-on-wood-elves.wav \
    e7-lotr-tone-b.wav \
    ../common/theme-piano.wav \
    e7-lotr-appeal-a.wav \
    e7-lotr-enough-information.wav \
    e7-lotr-appeal-b.wav \
    ../common/theme-high.wav \
    e7-hamburger-flavoring.wav \
    ../common/theme-high.wav \
    e7-closing.wav \
    ../common/theme-low.wav \
    e7-was-that-scary.wav \
    episode-7.wav
	lame src-audio/episode-7/episode-7.wav episodes/smallfindings-7-master-hamfast.mp3 \
    --tt "Small Findings Episode 7: Master Hamfast" \
    --ta "Jim Kang" \
    --ty 2020

episode-8:
	./prepare-audio.sh src-audio/episode-8
	cd src-audio/episode-8 && \
	sox \
    ../common/theme-high.wav \
    e8-intro.wav \
    ../common/theme-high.wav \
    polio-take-2.wav \
    ../common/theme-high.wav \
    whites-closing-ranks-a.wav \
    daily-satilla-shores.wav \
    whites-closing-ranks-b.wav \
    ../common/somber-sting.wav \
    cambridge-police.wav \
    ../common/somber-sting.wav \
    e8-closing.wav \
    episode-8.wav
	lame src-audio/episode-8/episode-8.wav episodes/smallfindings-8-then-and-now.mp3 \
    --tt "Small Findings Episode 8: Then and Now" \
    --ta "Jim Kang" \
    --ty 2020

episode-9:
	./prepare-audio.sh src-audio/episode-9
	cd src-audio/episode-9 && \
	sox \
    cold-open.wav \
    ../common/silence-700ms.wav \
    ../common/theme-high.wav \
    opening.wav \
    ../common/theme-high.wav \
    bridge-narration-1.wav \
    bridge-1.wav \
    ../common/silence-700ms.wav \
    bridge-narration-2.wav \
    bridge-2.wav \
    ../common/silence-700ms.wav \
    bridge-narration-3.wav \
    ../common/silence-700ms.wav \
    bridge-3.wav \
    bridge-narration-4.wav \
    bridge-4.wav \
    bridge-narration-5.wav \
    bridge-5.wav \
    bridge-narration-6.wav \
    bridge-6.wav \
    bridge-narration-7.wav \
    ../common/silence-700ms.wav \
    ../common/silence-700ms.wav \
    ../common/theme-high.wav \
    literal-nazi-speech.wav \
    ../common/theme-high.wav \
    ../common/silence-700ms.wav \
    work-force.wav \
    ../common/silence-700ms.wav \
    ../common/theme-high.wav \
    library-book-drop.wav \
    ../common/silence-700ms.wav \
    ../common/theme-high.wav \
    closing.wav \
    ../common/theme-low.wav \
    episode-9.wav
	lame src-audio/episode-9/episode-9.wav episodes/smallfindings-9-land-of-wonder.mp3 \
    --tt "Small Findings Episode 9: Land of Wonder" \
    --ta "Jim Kang" \
    --ty 2020

episode-10:
	./prepare-audio.sh src-audio/episode-10
	cd src-audio/episode-10 && \
	sox \
    ../common/theme-high.wav \
    intro.wav \
    ../common/theme-high.wav \
    surnameless.wav \
    ../common/theme-high.wav \
    gomboc.wav \
    ../common/theme-high.wav \
    lenin-1.wav \
    lenin-quote-1.wav \
    lenin-2.wav \
    lenin-quote-2.wav \
    lenin-3.wav \
    lenin-quote-3.wav \
    lenin-4.wav \
    lenin-quote-4.wav \
    lenin-5.wav \
    lenin-quote-5.wav \
    lenin-6.wav \
    lenin-quote-6.wav \
    lenin-7.wav \
    lenin-quote-7.wav \
    lenin-8.wav \
    ../common/theme-high.wav \
    closing.wav \
    ../common/theme-low.wav \
    episode-10.wav
	lame src-audio/episode-10/episode-10.wav episodes/smallfindings-10-the-gomboc.mp3 \
    --tt "Small Findings Episode 10: The Gömböc" \
    --ta "Jim Kang" \
    --ty 2020

episode-11:
	./prepare-audio.sh src-audio/episode-11
	cd src-audio/episode-11 && \
	sox \
    ../common/theme-high.wav \
    intro-e11.wav \
    ../common/theme-high.wav \
    autocorrelation.wav \
    ../common/theme-high.wav \
    llc.wav \
    ../common/theme-high.wav \
    woods-1.wav \
    ../common/silence-700ms.wav \
    woods-2.wav \
    ../common/silence-700ms.wav \
    woods-3.wav \
    ../common/silence-700ms.wav \
    woods-4.wav \
    ../common/theme-piano.wav \
    closing-e11.wav \
    ../common/theme-low.wav \
    episode-11.wav
	lame src-audio/episode-11/episode-11.wav episodes/smallfindings-11-100000-hot-dogs.mp3 \
    --tt "Small Findings Episode 11: 100,000 Hot Dogs" \
    --ta "Jim Kang" \
    --ty 2020

episode-12:
	./prepare-audio.sh src-audio/episode-12
	cd src-audio/episode-12 && \
	sox \
    ../common/theme-high.wav \
    e12-intro.wav \
    ../common/theme-high.wav \
    pasta.wav \
    ../common/theme-high.wav \
    snuff.wav \
    ../common/theme-high.wav \
    cats-a.wav \
    ../common/theme-piano.wav \
    cats-b.wav \
    ../common/theme-high.wav \
    e12-closing.wav \
    ../common/theme-low.wav \
    outtake-katt.wav \
    episode-12.wav
	lame src-audio/episode-12/episode-12.wav episodes/smallfindings-12-pasta-snuff-and-cats.mp3 \
    --tt "Small Findings Episode 12: Pasta, Snuff, and Cats" \
    --ta "Jim Kang" \
    --ty 2020

episode-13:
	./prepare-audio.sh src-audio/episode-13
	cd src-audio/episode-13 && \
	sox \
    ../common/theme-high.wav \
    e13-opening.wav \
    ../common/theme-high.wav \
    paid-for-art.wav \
    ../common/theme-high.wav \
    roomba-redux.wav \
    ../common/theme-high.wav \
    seph.wav \
    ../common/theme-piano.wav \
    filamentation.wav \
    ../common/theme-piano.wav \
    linebreaks.wav \
    ../common/theme-high.wav \
    e13-closing.wav \
    ../common/theme-low.wav \
    episode-13.wav
	lame src-audio/episode-13/episode-13.wav episodes/smallfindings-13-who-is-the-robot-now.mp3 \
    --tt "Small Findings Episode 13: Who Is the Robot Now?" \
    --ta "Jim Kang" \
    --ty 2021

episode-14:
	./prepare-audio.sh src-audio/episode-14
	cd src-audio/episode-14 && \
	sox \
    ../common/theme-high.wav \
    e14-opening.wav \
    ../common/theme-high.wav \
    cleary.wav \
    ../common/theme-high.wav \
    sun-ra-1.wav \
    ../common/theme-high.wav \
    cadr.wav \
    ../common/theme-high.wav \
    douglass.wav \
    buxton.wav \
    ../common/theme-high.wav \
    e14-closing-a.wav \
    ../common/theme-piano.wav \
    e14-closing-b.wav \
    ../common/theme-low.wav \
    episode-14.wav
	lame src-audio/episode-14/episode-14.wav episodes/smallfindings-14-recumbent-findings.mp3 \
    --tt "Small Findings Episode 14: Recumbent Findings" \
    --ta "Jim Kang" \
    --ty 2021

episode-15:
	./prepare-audio.sh src-audio/episode-15
	cd src-audio/episode-15 && \
	sox \
    ../common/theme-high.wav \
    e15-opening.wav \
    ../common/theme-high.wav \
    bike-locks.wav \
    ../common/theme-high.wav \
    laser-printer-drm.wav \
    ../common/theme-high.wav \
    sherlock-holmes.wav \
    ../common/theme-high.wav \
    e15-closing.wav \
    ../common/theme-low.wav \
    episode-15.wav
	lame src-audio/episode-15/episode-15.wav episodes/smallfindings-15-light-criminology.mp3 \
    --tt "Small Findings Episode 15: Light Criminology" \
    --ta "Jim Kang" \
    --ty 2021

episode-16:
	./prepare-audio.sh src-audio/episode-16
	cd src-audio/episode-16 && \
	sox \
    ../common/theme-high.wav \
    e16-opening.wav \
    ../common/theme-high.wav \
    decibels.wav \
    ../common/theme-high.wav \
    arneson-and-gygax.wav \
    ../common/theme-high.wav \
    non-leopard-wily.wav \
    ../common/theme-high.wav \
    e16-closing.wav \
    ../common/theme-low.wav \
    episode-16.wav
	lame src-audio/episode-16/episode-16.wav episodes/smallfindings-16-incorrect-attributions.mp3 \
    --tt "Small Findings Episode 16: Incorrect Attributions" \
    --ta "Jim Kang" \
    --ty 2021

episode-17:
	./prepare-audio.sh src-audio/episode-17
	cd src-audio/episode-17 && \
	sox \
    ../common/theme-high.wav \
    e17-opening.wav \
    ../common/theme-high.wav \
    recording-computer-programs-that-are-bad-musicians.wav \
    ../common/theme-high.wav \
    sandwich-spread.wav \
    ../common/theme-high.wav \
    band-messages-and-politicians.wav \
    ../common/theme-high.wav \
    e17-closing.wav \
    ../common/theme-low.wav \
    episode-17.wav
	lame src-audio/episode-17/episode-17.wav episodes/smallfindings-17-sandwich-spread.mp3 \
    --tt "Small Findings Episode 17: Sandwich Spread" \
    --ta "Jim Kang" \
    --ty 2021

episode-18:
	#./prepare-audio.sh src-audio/episode-18
	cd src-audio/episode-18 && \
	sox \
    ../common/theme-high.wav \
    e18-opening.wav \
    ../common/theme-high.wav \
    westminster-quarters-with-clips.wav \
    ../common/theme-high.wav \
    delay-1.wav \
    examples/aligned.wav \
    delay-2.wav \
    examples/offby010seconds.wav \
    delay-3.wav \
    examples/offby003seconds.wav \
    delay-4.wav \
    examples/aligned.wav \
    delay-5.wav \
    examples/offby001seconds.wav \
    delay-6.wav \
    examples/aligned.wav \
    delay-7.wav \
    examples/offby001seconds.wav \
    delay-8.wav \
    examples/vib-aligned.wav \
    delay-9.wav \
    examples/vib-offby010seconds.wav \
    delay-10.wav \
    examples/vib-offby010seconds.wav \
    delay-11.wav \
    examples/vib-aligned.wav \
    delay-12.wav \
    examples/vib-offby003seconds.wav \
    delay-13.wav \
    examples/vib-aligned.wav \
    delay-14.wav \
    ../common/theme-high-with-delay.wav \
    e18-closing.wav \
    ../common/theme-low.wav \
    episode-18.wav
	lame src-audio/episode-18/episode-18.wav episodes/smallfindings-18-bells-and-delay.mp3 \
    --tt "Small Findings Episode 18: Bells and Delay" \
    --ta "Jim Kang" \
    --ty 2021

episode-19:
	./prepare-audio.sh src-audio/episode-19
	cd src-audio/episode-19 && \
	sox \
    ../common/theme-high.wav \
    e19-opening.wav \
    ../common/theme-high.wav \
    catbird-1.wav \
    Catbird.wav \
    catbird-2.wav \
    ../common/theme-high.wav \
    bandcamp.wav \
    ../common/time-passing-unresolved.wav \
    bandcamp-update-a.wav \
    ../common/time-passing-resolved.wav \
    bandcamp-update.wav \
    ../common/theme-high.wav \
    grasshoppers.wav \
    ../common/theme-high.wav \
    bitcoin.wav \
    ../common/theme-high.wav \
    e19-closing.wav \
    ../common/theme-low.wav \
    episode-19.wav
	lame src-audio/episode-19/episode-19.wav episodes/smallfindings-19-weird-animal-sounds.mp3 \
    --tt "Small Findings Episode 19: Weird Animal Sounds" \
    --ta "Jim Kang" \
    --ty 2021
