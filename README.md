smallfindings
==================

The source for the Small Findings podcast.

Installation
------------

- Clone this repo.
- Record your own podcast episodes.
- Update the config files.
- `npm install`
- Create a config.mk that defines `USER` and `SERVER`.

Usage
-----

Whenever you add a new episode, put the new audio file down, fill out a new Markdown file, then run:

    make build
    make pushall
