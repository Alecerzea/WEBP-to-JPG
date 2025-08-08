@echo off
REM Check if ffmpeg is available
where ffmpeg >nul 2>&1
if errorlevel 1 (
    echo ffmpeg is not installed or not in PATH. Please install it first.
    exit /b 1
)

REM Check for .webp files in current directory
setlocal enabledelayedexpansion
set count=0

for %%f in (*.webp) do (
    set /a count+=1
)

if %count%==0 (
    echo No .webp files found in the current directory.
    exit /b 1
)

REM Process each .webp file
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
