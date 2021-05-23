  #!/bin/bash

  basedir=$1
  m4adir=${basedir}/m4a
  dir=${basedir}/mono
  stereodir=${basedir}/stereo
  outdir=${basedir}
  mkdir -p "${stereodir}"

  for file in ${m4adir}/*.m4a
  do
    filepathbase=${file##*/}
    filenamebase="${filepathbase%.*}"
    wavname="${dir}/${filenamebase}.wav"
    ffmpeg -i "${file}" "${wavname}"
  done

  for file in ${dir}/*.wav
  do
    filename=${file##*/}
    stereofile="${stereodir}/${filename}"
    outfile="${outdir}/${filename}"
    echo "Converting to stereo: ${stereofile}."
    sox -M "${file}" "${file}" "${stereofile}"
    #echo "Converting to stereo and adding reverb: ${stereofile}."
    #sox -M "${file}" "${file}" "${stereofile}" gain -1 reverb 0.5 50 100 100
    echo "Converting to 44.1 kHz sample rate and normalizing"
    sox "${stereofile}" --norm=-1 -r 44100 "${outfile}"
  done
