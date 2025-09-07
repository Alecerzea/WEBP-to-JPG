#!/bin/bash

# Find .webp files
mapfile -t webp_files < <(find . -type f -iname "*.webp")

if [ ${#webp_files[@]} -eq 0 ]; then
    echo "No .webp files found in current directory or subdirectories."
    exit 1
fi

# Convert each .webp to .jpg
for file in "${webp_files[@]}"; do
    jpg="${file%.webp}.jpg"
    echo "[+] Converting $file to $jpg..."
    ffmpeg -loglevel error -i "$file" "$jpg"
    if [ -f "$jpg" ]; then
        rm -f "$file"
        echo "[✓] Converted and removed $file"
    else
        echo "[!] Failed to convert $file"
    fi
done

echo
echo "[✓] All .webp files processed."
