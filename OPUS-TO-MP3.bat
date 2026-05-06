@echo off
for %%f in (*.opus) do (
    echo Converting %%f ...
    ffmpeg -i "%%f" -vn -acodec libmp3lame -ab 192k "%%~nf.mp3"
)
echo Done!
pause
