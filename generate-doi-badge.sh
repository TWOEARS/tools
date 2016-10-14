#!/bin/bash
DOI="$1"
BASEURL="https://img.shields.io/badge/DOI-"
COLOR="blue"
EXTENSION="svg"

URL="${BASEURL}${DOI}-${COLOR}.${EXTENSION}"
FILE="doi-${DOI/\//-}.${EXTENSION}"

curl -s -o "$FILE" "$URL"
echo "Stored in $FILE"
