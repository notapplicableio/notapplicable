#!/bin/zsh
set -e

SCRIPT_DIR="${0:A:h}"
DOCC_BUNDLE="$SCRIPT_DIR/NotApplicable.docc"
OUTPUT_DIR="$SCRIPT_DIR/../notapplicable-main"

echo "Building DocC site..."
xcrun docc convert "$DOCC_BUNDLE" \
    --output-path "$DOCC_BUNDLE/.docc-build" \
    --hosting-base-path /

echo "Syncing to $OUTPUT_DIR..."
rsync -a \
    --exclude='.git' \
    "$DOCC_BUNDLE/.docc-build/" \
    "$OUTPUT_DIR/"

echo "Committing and pushing..."
cd "$OUTPUT_DIR"
git add -A
git commit -m "Regenerate site"
git push origin main

echo "Done. Site will be live shortly at https://notapplicable.io"
