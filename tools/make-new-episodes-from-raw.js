#!/usr/bin/env node

import { readdir, readFile, access } from 'fs/promises';
import { constants } from 'fs';
import path from 'path';
import noThrowJSONParse from 'no-throw-json-parse';
import slugify from '@sindresorhus/slugify';
import compact from 'lodash.compact';

var entryJSONRegex = /sf-raw-\w{8}\.json/;

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
    let entriesWithoutEpisodes = compact(
      await Promise.all(files.map(getEntryIfNoEpisode))
    );
    console.log(entriesWithoutEpisodes);
  } catch (error) {
    conclude(error);
  }
}

async function getEntryIfNoEpisode(entryFile) {
  var entry = noThrowJSONParse(
    await readFile(path.join('sf-raw/meta/', entryFile), { encoding: 'utf8' })
  );
  if (!entry) {
    return;
  }
  const slug = slugify(entry.caption.split('|').shift());
  const episodePath = path.join('episodes', slug + '.njk');
  // Does the episode exist?
  try {
    await access(episodePath, constants.R_OK);
  } catch (error) {
    console.error('File does not exist (which is fine):', episodePath);
    return;
  }
  entry.slug = slug;
  entry.episodePath = episodePath;
  return entry;
}

function conclude(error) {
  if (error) {
    console.error(error, error.stack);
    return;
  }
  console.log('Done.');
}

