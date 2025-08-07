# Convert and delete .webp files
for file in *.webp; do
    base="${file%.webp}"
    
    # Convert to jpg
    if ffmpeg -i "$file" "${base}.jpg"; then
        # Remove original if conversion succeeded
        rm "$file"
        echo "Converted and removed: $file"
    else
        echo "Failed to convert: $file"
    fi
done

echo "All done!"
