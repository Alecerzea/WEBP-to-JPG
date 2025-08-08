@echo off
title WEBP to JPG Converter and Cleaner
color 0A

:: Check for ffmpeg
ffmpeg -version >nul 2>&1
if errorlevel 1 (
    echo ffmpeg is not installed or not in PATH.
    pause
    exit /b
)

:: Process each .webp file in current folder
for %%F in (*.webp) do (
    set "file=%%F"
    set "base=%%~nF"

    call :ConvertAndDelete
)

echo All done!
pause
exit /b

:ConvertAndDelete
:: Convert to JPG
ffmpeg -y -i "%file%" "%base%.jpg" >nul 2>&1
if errorlevel 1 (
    echo Failed to convert: %file%
) else (
    del "%file%"
    echo Converted and removed: %file%
)
exit /b
