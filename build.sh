#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

echo "Build script initialized."

# Jekyll build.
jekyll build

# Make an epub.
pandoc -S -t epub -o assets/build/sharons-cookbook.epub --epub-metadata=assets/epub-metadata.xml --epub-cover-image=assets/epub-cover-image.png --epub-stylesheet=assets/epub-stylesheet.css _site/ebook/index.html

# Make a pdf.
pandoc -S -o assets/build/book-plain.pdf --latex-engine=xelatex _site/ebook/index.html
pdfunite assets/pdf_cover.pdf assets/build/book-plain.pdf assets/build/sharons-cookbook.pdf
rm assets/build/book-plain.pdf

# Use epub to make a mobi.
cd assets/build
kindlegen sharons-cookbook.epub