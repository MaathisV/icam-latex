#!/bin/bash

set -e  # Exit on first error

# Ask user for install scope
read -p "Install for current user (Y) or system-wide (N)? [Y/n]: " SCOPE
SCOPE=${SCOPE:-Y}

if [[ "$SCOPE" =~ ^[Yy]$ ]]; then
  DEST=$(kpsewhich -var-value=TEXMFHOME)
else
  DEST=$(kpsewhich -var-value=TEXMFLOCAL)
  
  # Check write access
  if [ ! -w "$DEST" ]; then
    echo "You do not have write permissions to $DEST. Try running with sudo."
    exit 1
  fi
fi

# Create target directory if it doesn't exist
TARGET_DIR="$DEST/tex/latex"
mkdir -p "$TARGET_DIR"

# Download latest release from GitHub
# ZIP_URL=$(curl -s https://api.github.com/repos/qaniere/icam-latex/releases/latest | grep "browser_download_url.*icam-latex.zip" | cut -d '"' -f 4)
# if [ -z "$ZIP_URL" ]; then
#   echo "Could not find the download URL for icam-latex.zip"
#   exit 1
# fi

# echo "Downloading icam-latex.zip from: $ZIP_URL"
# curl -L "$ZIP_URL" -o /tmp/icam-latex.zip

# Extract to destination
unzip -o ./icam-latex.zip -d "$TARGET_DIR"

echo "icam LaTeX installed to $TARGET_DIR"
