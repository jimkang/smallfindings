#!/usr/bin/env node

// WARNING: This expects to be run from the project root directory.

import { readdir, readFile, access, copyFile, rmdir, mkdir, writeFile } from 'fs/promises';
import { constants } from 'fs';
import path from 'path';
import noThrowJSONParse from 'no-throw-json-parse';
import slugify from '@sindresorhus/slugify';
import compact from 'lodash.compact';
import { promisify } from 'util';
import childProcess from 'child_process';

var exec = promisify(childProcess.exec);

const rawSitePath = 'sf-raw';
var entryJSONRegex = /sf-raw-\w{8}\.json/;
var epNumberRegex = /smallfindings-(\d+)-[\w-]+\.mp3/;

/* global process */

if (process.argv.length < 3) {
  console.error(
    'Usage: node tools/make-new-episodes-from-raw.js <raw audio site dir>'
  );
  process.exit(1);
}

const rawDir = process.argv[2];
go();

async function go() {
  try {
    let files = (await readdir(path.join(rawDir, 'meta')))
      .filter(file => file.match(entryJSONRegex));
    const latestEpisodeNumber = await getLatestEpisodeNumber();
    console.log('latestEpisodeNumber', latestEpisodeNumber);
    let entriesWithoutEpisodes = compact(
      await Promise.all(files.map(getEntryIfNoEpisode))
    );
    console.log(entriesWithoutEpisodes);
    // Unless you change assembleAudio to use unique tmp dirs, these have to
    // go one at a time.
    for (let i = 0; i < entriesWithoutEpisodes.length; ++i) {
      let entry = entriesWithoutEpisodes[i];
      entry.episodeNumber = latestEpisodeNumber + i + 1;
      await produceEpisode(entry);
    }
  } catch (error) {
    conclude(error);
  }
}

// #throws
async function prepareDirs() {
  await rmdir('tmp', { recursive: true });
  await mkdir('tmp/m4a', { recursive: true });
  await mkdir('tmp/mono', { recursive: true });
  await mkdir('tmp/stereo', { recursive: true });
}
  
async function getEntryIfNoEpisode(entryFile) {
  var entry = noThrowJSONParse(
    await readFile(path.join(rawSitePath, 'meta', entryFile), { encoding: 'utf8' })
  );
  if (!entry) {
    return;
  }
  const title = entry.caption.split('|').shift();
  const slug = slugify(title);
  const episodePath = path.join('episodes', slug + '.njk');
  // Does the episode exist?
  try {
    await access(episodePath, constants.R_OK);
    return;
  } catch (error) {
    console.error('File does not exist (which is fine):', episodePath);
    entry.title = title;
    entry.slug = slug;
    entry.episodePath = episodePath;
    return entry;
  }
}

async function produceEpisode(entry) {
  await assembleAudio(entry);
  await assembleTemplate(entry);
}

// #throws
async function assembleAudio({ mediaFilename, slug, episodeNumber, title }) {
  await prepareDirs();

  const { base, ext } = path.parse(mediaFilename);
  const resultBasename = `smallfindings-${episodeNumber}-${slug}`;
  const segmentWavPath = path.join(process.cwd(), 'tmp', resultBasename + '.wav');
  const episodeWavPath = `episodes/${resultBasename}-assembled.wav`;
  const mp3Filepath = `episodes/${resultBasename}.mp3`;
  if (ext === '.m4a') {
    await copyFile(path.join(rawSitePath, 'media', mediaFilename), `tmp/m4a/${resultBasename}.m4a`);
  } else if (ext === '.mp3') {
    // We're guessing here.
    await copyFile(path.join(rawSitePath, 'media', mediaFilename), `tmp/mono/${resultBasename}.mp3`);
  } else {
    throw new Error(`Don't know what to do with this file extension: ${base}`);
  }

  if (!(await execCmd('./prepare-audio.sh ' + path.join(process.cwd(), 'tmp')))) {
    throw new Error(`Could not prepare directories for ${base}.`);
  }
   
  if (!(await execCmd(`sox \
    src-audio/common/theme-high.wav \
    "${segmentWavPath}" \
    src-audio/common/theme-low.wav \
    "${episodeWavPath}"
  `))) {
    return;
  }

  await execCmd(`lame "${episodeWavPath}" "${mp3Filepath}" \
    --tt "Small Findings Episode ${episodeNumber}: ${title}" \
    --ta "Jim Kang" \
    --ty ${(new Date()).getFullYear()}`);
   
  return mp3Filepath;
}

async function execCmd(cmd) {
  try {
    //console.log('cwd:', process.cwd());
    await exec(cmd, { shell: '/bin/bash' });
    return true;
  } catch (error) {
    console.error('Error while trying running', cmd, '\n', 'Error:', error, 'stderr:', error.stderr);
    return false;
  }
}

function assembleTemplate({ slug, episodeNumber, title, date }) {
  const cleanedTitle = title.replace(/:/g, ' —');
  const njkContent = `---
layout: episode.njk
stuff:
  title: >
    Episode ${episodeNumber}: ${cleanedTitle}
  slug: ${slug}
  season: 1
  number: ${episodeNumber}
  date: ${date}
  imageFilename: small-findings.jpg
  seconds: 1459
  findings:
    - 
      text: ${cleanedTitle}
`; 
  
  // TODO: Get actual episode length.
  return writeFile(path.join('episodes', slug + '.njk'), njkContent, { encoding: 'utf8' });
}
  
async function getLatestEpisodeNumber() {
  return (await readdir('episodes'))
    .filter(file => file.endsWith('.mp3'))
    .map(getEpisodeNumberFromFilename)
    .reduce((latest, n) => n > latest ? n : latest, 0);
}

function getEpisodeNumberFromFilename(file) {
  var results = epNumberRegex.exec(file);
  if (results && results.length > 1) {
    return +results[1];
  }
  return 0;
}

function conclude(error) {
  if (error) {
    console.error(error, error.stack);
    return;
  }
  console.log('Done.');
}

