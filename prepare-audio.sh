  #!/bin/bash

  basedir=$1
  dir=${basedir}/mono
  stereodir=${basedir}/stereo
  outdir=${basedir}
  for file in ${dir}/*.wav
  do
    filename=${file##*/}
    stereofile="${stereodir}/${filename}"
    outfile="${outdir}/${filename}"
    echo "Converting to stereo and adding reverb: ${stereofile}."
    sox -M "${file}" "${file}" "${stereofile}" gain -1 reverb 2 50 100 100
    echo "Converting to 44.1 kHz sample rate and normalizing"
    sox "${stereofile}" --norm=-1 -r 44100 "${outfile}"
  done
