#!/bin/bash

basedir=src-audio/common
outdir=${basedir}/processed
mkdir -p "${outdir}"

for file in ${basedir}/*.wav
do
  filename=${file##*/}
  outfile="${outdir}/${filename}"
  sox "${file}" \
    --norm=-6 \
    "${outfile}"
done
