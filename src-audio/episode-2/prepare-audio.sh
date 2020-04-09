  #!/bin/bash

  dir=mono
  stereodir=stereo
  outdir=.
  for file in ${dir}/*.wav
  do
    filename=${file##*/}
    stereofile="${stereodir}/${filename}"
    outfile="${outdir}/${filename}"
    echo "Converting to stereo: ${stereofile}."
    sox -M "${file}" "${file}" "${stereofile}"
    echo "Converting to 44.1 kHz sample rate and normalizing"
    sox "${stereofile}" --norm=-1 -r 44100 "${outfile}"
  done
