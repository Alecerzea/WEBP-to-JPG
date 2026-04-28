@echo off
for %%f in (*.ogg) do (
    ffmpeg -i "%%f" -q:a 2 "%%~nf.mp3"
)
pause