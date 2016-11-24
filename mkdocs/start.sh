#!/bin/sh

mkdocs build
rsync -r --delete ./site/ ../nginx/html
