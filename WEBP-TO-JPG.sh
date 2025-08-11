#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg >/dev/null 2>&1; then
    echo "ffmpeg is not installed or not in PATH. Please install it first."
    exit 1
fi

# Find .webp files in current directory
webp_files=( *.webp )

if [ ! -e "${webp_files[0]}" ]; then
    echo "No .webp files found in the current directory."
    exit 1
fi

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