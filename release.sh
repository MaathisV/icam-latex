#!/bin/bash

# exit at first error
set -e

TEMPLATES=("icam-beamer" "icam-report")

# Clean old zips
rm -f icam-*-overleaf.zip icam-latex.zip

# Create Overleaf zips
# for template in "${TEMPLATES[@]}"; do
#   zipname="${template}-overleaf.zip"
#   echo "Creating $zipname..."

#   mkdir -p tmp-overleaf
#   cp "${template}/main.tex" tmp-overleaf/
#   cp -r "${template}" tmp-overleaf/
#   rm "tmp-overleaf/${template}/main.tex"
#   cp -r icam-common tmp-overleaf/

#   (cd tmp-overleaf && zip -r "../$zipname" .)

#   rm -rf tmp-overleaf
# done

# Create global zip
echo "Creating icam-latex.zip..."

mkdir -p tmp-global
for template in "${TEMPLATES[@]}"; do
  mkdir -p "tmp-global/${template}"
  find "${template}" -type f ! -name 'main.tex' -exec cp --parents {} tmp-global/ \;
done

cp -r icam-common tmp-global/

(cd tmp-global && zip -r ../icam-latex.zip .)

rm -rf tmp-global

echo "All archives created."
