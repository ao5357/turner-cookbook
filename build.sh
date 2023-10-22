#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

echo "Build script initialized."

# Jekyll build.
bundle exec jekyll build
cd _site/ebook

# Make an epub.
pandoc -S -t epub -o ../../assets/build/sharons-cookbook.epub --epub-metadata=../../assets/epub-metadata.xml --epub-cover-image=../../assets/epub-cover-image.png --epub-stylesheet=../../assets/epub-stylesheet.css index.html

# Make a pdf.
pandoc -S -o ../../assets/build/book-plain.pdf --latex-engine=xelatex index.html
pdfunite ../../assets/pdf_cover.pdf ../../assets/lulu-covers.pdf ../../assets/build/book-plain.pdf ../../assets/blank-page.pdf ../../assets/build/sharons-cookbook.pdf

# Make another pdf for lulu.
pdfunite ../../assets/lulu-covers.pdf ../../assets/build/book-plain.pdf ../../assets/blank-page.pdf ../../assets/build/book-nocover.pdf
gs -o ../../assets/build/book-lulu.pdf -sDEVICE=pdfwrite -dPDFFitPage -r300x300 -g2475x3225 ../../assets/build/book-nocover.pdf
#pdfcrop --margins '-37 -37 -38 -38' ../../assets/build/book-nocover.pdf ../../assets/build/book-lulu.pdf

rm ../../assets/build/book-plain.pdf
rm ../../assets/build/book-nocover.pdf

# Word processor format
pandoc -S -o ../../assets/build/sharons-cookbook.docx index.html

# Plain text (markdown) format
pandoc -S -t markdown -o ../../assets/build/sharons-cookbook.md.txt index.html

# Use epub to make a mobi.
cd ../../assets/build
#kindlegen sharons-cookbook.epub
