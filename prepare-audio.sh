#!/bin/bash

basedir=$1
m4adir=${basedir}/m4a
mp3dir=${basedir}/mp3
dir=${basedir}/mono
stereodir=${basedir}/stereo
outdir=${basedir}
mkdir -p "${dir}"
mkdir -p "${stereodir}"
echo "basedir: ${basedir}"

for file in ${m4adir}/*.m4a
do
  filepathbase=${file##*/}
  filenamebase="${filepathbase%.*}"
  wavname="${dir}/${filenamebase}.wav"
  ffmpeg -i "${file}" "${wavname}"
done

# Big assumption that mp3s are already in stereo.
for file in ${mp3dir}/*.mp3
do
  filepathbase=${file##*/}
  filenamebase="${filepathbase%.*}"
  wavname="${filenamebase}.wav"
  stereofile="${stereodir}/${wavname}"
  ffmpeg -i "${file}" "${stereofile}"
done

for file in ${dir}/*.wav
do
  filename=${file##*/}
  stereofile="${stereodir}/${filename}"
  outfile="${outdir}/${filename}"
  echo "Converting to stereo: ${stereofile}."
  sox -M "${file}" "${file}" "${stereofile}"
done

echo "Converting to 44.1 kHz sample rate, eqing, and normalizing"
# Remove crackle with eq, roll off plosives with highpass.
for file in ${stereodir}/*.wav
do
  filename=${file##*/}
  stereofile="${stereodir}/${filename}"
  outfile="${outdir}/${filename}"
  echo "Normalizing: ${stereofile}."
  sox "${stereofile}" \
    --norm=-1 \
    -r 44100  \
    --guard \
    "${outfile}" \
    highpass 130 4q
    #equalizer 5k 1.0q -7 \
    #equalizer 6.3k 5.0q -20 \
    #equalizer 8k 5.0q -20 \
    #equalizer 10k 5.0q -20 \
    #equalizer 12k 5.0q -20 \
done
