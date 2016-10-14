#!/bin/bash
#  See: http://askubuntu.com/questions/50170/how-to-convert-pdf-to-image/50180
convert -density 150 "$1" -quality 90 "${1%.pdf}.png"
