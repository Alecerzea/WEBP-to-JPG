@echo off
REM Check if ffmpeg is installed
where ffmpeg >nul 2>&1
if errorlevel 1 (
    echo [!] ffmpeg is not installed. Installing with winget...
    winget install -e --id Gyan.FFmpeg
    where ffmpeg >nul 2>&1
    if errorlevel 1 (
        echo [✗] Failed to install ffmpeg. Aborting.
        exit /b 1
    ) else (
        echo [✓] ffmpeg installed successfully.
    )
)

setlocal enabledelayedexpansion
set count=0

REM Count .webp files
for %%f in (*.webp) do (
    set /a count+=1
)

if %count%==0 (
    echo No .webp files found in the current directory.
    exit /b 1
)

REM Convert each file
for %%f in (*.webp) do (
    set "file=%%f"
    set "jpg=%%~nf.jpg"
    echo [+] Converting %%f to !jpg!...
    ffmpeg -loglevel error -i "%%f" "!jpg!"
    if exist "!jpg!" (
        del /f "%%f"
        echo [✓] Converted and removed %%f
    ) else (
        echo [!] Failed to convert %%f
    )
)

echo.
echo [✓] All .webp files processed.
