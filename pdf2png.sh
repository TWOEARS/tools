#!/bin/bash
convert -density 500 -resize '1000' "$1" "${1%.pdf}.png"
