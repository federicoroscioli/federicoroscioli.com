#!/bin/bash
# optimize-photos.sh
# Reads the original ~2000px JPGs from assets/photos/ and writes web-optimized
# copies (long edge capped at 1600px, JPEG quality 80) to assets/photos-web/.
# The originals in assets/photos/ are never touched — rerun this whenever you
# add new photos and it will regenerate the web versions.

set -e
cd "$(dirname "$0")"          # always run from the site root, whoever calls it

mkdir -p assets/photos-web

for f in assets/photos/*.JPG; do
  name=$(basename "$f" .JPG)                 # e.g. calais001
  sips -Z 1600 --setProperty formatOptions 80 "$f" \
       --out "assets/photos-web/${name}.jpg" >/dev/null
  echo "optimized ${name}"
done

echo "Done. $(ls assets/photos-web/*.jpg | wc -l | tr -d ' ') web photos, total $(du -sh assets/photos-web | cut -f1)"
