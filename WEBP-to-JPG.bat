@echo off
setlocal enabledelayedexpansion

REM Check for .webp files
set "count=0"
for /r %%f in (*.webp) do (
    set /a count+=1
)

if !count! EQU 0 (
    echo No .webp files found in current directory or subdirectories.
    exit /b 1
)

REM Convert each .webp file to .jpg
for /r %%f in (*.webp) do (
    set "file=%%f"
    set "jpg=%%~dpnf.jpg"
    echo [+] Converting %%f to !jpg!...
    ffmpeg -loglevel error -i "%%f" "!jpg!"
    if exist "!jpg!" (
        del /f "%%f"
        echo [✓] Converted and removed %%f
    ) else (
        echo [!] Failed to convert %%f
    )
)
