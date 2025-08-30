# Check if ffmpeg is installed
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "[!] ffmpeg is not installed. Installing with winget..."
    winget install -e --id Gyan.FFmpeg
    if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
        Write-Host "[✗] Failed to install ffmpeg. Aborting."
        exit 1
    } else {
        Write-Host "[✓] ffmpeg installed successfully."
    }
}

# Get the directory from which the script is launched
$baseDir = Get-Location

# Get all .webp files recursively
$webpFiles = Get-ChildItem -Path $baseDir -Filter *.webp -File -Recurse

if ($webpFiles.Count -eq 0) {
    Write-Host "No .webp files found in the current directory or subfolders."
    exit
}

# Convert each file
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

Write-Host "`n[✓] All .webp files processed."
