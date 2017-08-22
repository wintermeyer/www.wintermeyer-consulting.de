#!/bin/bash

# This script deploys the static files for www.wintermeyer-consulting.de
#

# Build the HTML files
#
cd ~/Github/www.wintermeyer-consulting.de/jekyll/
echo "* Generating the HTML files with Jekyll"
JEKYLL_ENV=production jekyll build

echo -n "Number of generated HTML Files:"
find _site -name "*.*ml" | wc -l
echo

cd ~/Github/www.wintermeyer-consulting.de/
mkdir -p export/jekyll/
rm -rf export/jekyll/_site
cp -r jekyll/_site export/jekyll/

# Run HTML Minifier
#
echo "* Run html-minifier for all HTML files"
html-minifier -c conf/html-minifier.conf  --file-ext html --input-dir jekyll/_site/ --output-dir export/jekyll/_site/ 2>&1 /dev/null

echo "* Compress each HTML file"
find export/jekyll/_site -name "*.*ml" -exec echo -n "." \; -exec zopfli --i70 {} \;
echo

echo "* List file sizes"
find export/jekyll/_site -name "*.*ml.gz" -exec du -hs {} \;

# chmod a+r to be safe that the webserver can read everything
#
cd export/jekyll/_site
chmod -R a+r *
cd ../../..

# Create a tempfile
#
tempfoo=`basename $0`
TMPFILE=`mktemp /tmp/${tempfoo}.XXXXXX` || exit 1

echo "* Deploy with rsync"
rsync -rlpcgoDvz --log-file=$TMPFILE --delete export/jekyll/_site/* stefan@nassau.frankfurt.amooma.de:/var/www/www.wintermeyer-consulting.de/

# Remove the tempfile
#
rm -f $TMPFILE

# Remove the export
#
rm -rf export/jekyll
