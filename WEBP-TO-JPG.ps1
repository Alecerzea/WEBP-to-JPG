# Get all .webp files recursively
$webpFiles = Get-ChildItem -Recurse -Filter *.webp -File

if ($webpFiles.Count -eq 0) {
    Write-Host "No .webp files found in the current directory or subfolders."
    exit
}

# Convert each .webp file to .jpg
foreach ($file in $webpFiles) {
    $jpgPath = [System.IO.Path]::ChangeExtension($file.FullName, ".jpg")
    Write-Host "[+] Converting $($file.FullName) to $jpgPath..."
    ffmpeg -loglevel error -i "$($file.FullName)" "$jpgPath"
    if (Test-Path $jpgPath) {
        Remove-Item "$($file.FullName)" -Force
        Write-Host "[✓] Converted and removed $($file.FullName)"
    } else {
        Write-Host "[!] Failed to convert $($file.FullName)"
    }
}
