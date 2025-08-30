#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg >/dev/null 2>&1; then
    echo "[!] ffmpeg is not installed."
    echo "Please install ffmpeg manually (e.g., sudo apt install ffmpeg or brew install ffmpeg)"
    exit 1
fi

# Find all .webp files recursively
mapfile -t webp_files < <(find . -type f -iname "*.webp")

if [ ${#webp_files[@]} -eq 0 ]; then
    echo "No .webp files found in current directory or subdirectories."
    exit 1
fi

# Convert each file
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
