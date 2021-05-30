#!/bin/bash

# Higher q values mean narrower peaks.

for file in meta/before/*.wav
do
  filename=${file##*/}
  # Remove crackle with eq, roll off plosives with highpass.
  sox "${file}" \
    --norm=-1 \
    -r 44100 \
    --guard \
    "meta/after/${filename}" \
    equalizer 5k 1.0q -7 \
    equalizer 6.3k 5.0q -20 \
    equalizer 8k 5.0q -20 \
    equalizer 10k 5.0q -20 \
    equalizer 12k 5.0q -20 \
    highpass 130 4q
done
