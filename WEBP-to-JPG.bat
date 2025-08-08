@echo off
title WEBP to JPG Converter - Batch
color 0A

:: Check if ffmpeg exists in PATH
ffmpeg -version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] ffmpeg is not installed or not in PATH.
    echo Download from: https://www.gyan.dev/ffmpeg/builds/
    pause
    exit /b
)

echo [+] Converting all .webp images in: %cd%
echo.

:: Loop through all .webp files in the current directory
for %%F in (*.webp) do (
    echo Converting: %%F
    ffmpeg -y -i "%%F" "%%~nF.jpg"
)

echo.
echo [✓] All conversions complete.
pause
