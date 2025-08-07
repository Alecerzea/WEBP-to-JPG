# Check for yt-dlp
if (-not (Get-Command yt-dlp -ErrorAction SilentlyContinue)) {
    Write-Host "yt-dlp is not installed or not in PATH."
    exit
}

# Check for ffmpeg
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "ffmpeg is not installed or not in PATH."
    exit
}

# Prompt for input
$mediaURL = Read-Host "Enter media URL"
$type = Read-Host "Is this a video or audio? (v/a)"
$timestamp = Get-Date -UFormat %s
$filename = "download_$timestamp"

if ($type -eq "v") {
    Write-Host "[+] Downloading video..."
    yt-dlp -o "${filename}.mp4" --format mp4 $mediaURL

} elseif ($type -eq "a") {
    Write-Host "[+] Downloading audio as MP3..."
    yt-dlp -x --audio-format mp3 -o "${filename}.mp3" $mediaURL

} else {
    Write-Host "Invalid input. Use 'v' for video or 'a' for audio."
    exit
}

Write-Host "`n[✓] Done."
