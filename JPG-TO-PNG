#!/bin/bash

for file in *.jpg *.jpeg; do
    [ -e "$file" ] || continue  # skip if no matches

    name="${file%.*}"
    ffmpeg -y -i "$file" "$name.png"

    echo "Converted $file → $name.png"
done

echo "All conversions done!"
