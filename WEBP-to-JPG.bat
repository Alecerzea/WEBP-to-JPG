@echo off
title WEBP to JPG Converter
color 0A

:: Check for ffmpeg
ffmpeg -version >nul 2>&1
if errorlevel 1 (
    echo ffmpeg is not installed or not in PATH.
    pause
    exit /b
)

:: Check if there are any .webp files
dir /b *.webp >nul 2>&1
if errorlevel 1 (
    echo No .webp files found in the current directory.
    pause
    exit /b
)

:: Loop through all .webp files in the current directory
for %%F in (*.webp) do (
    set "input=%%F"
    set "output=%%~nF.jpg"
    echo [+] Converting %%F to %%~nF.jpg...
    ffmpeg -y -i "%%F" "%%~nF.jpg" >nul 2>&1
)

echo.
echo [✓] Done.
pause
