@echo off
echo #--------------------------------------#
echo - TrimUI Smart Pro - Music Video Maker -
echo #--------------------------------------#
echo Converting Cover Image...
for %%f in (*.jpg *.png) do (
    ffmpeg -loglevel panic -i "%%f" -y -vf "scale=640:360:force_original_aspect_ratio=decrease,pad=640:360:-1:-1:color=black" "cover.jpg"
)
echo Converting MP3 to MP4...
for %%G in (*.mp3) do (
    ffmpeg -loglevel panic -y -loop 1 -i cover.jpg -i "%%G" -c:v libx264 -tune stillimage -c:a mp3 -pix_fmt yuv420p -shortest "%%~nG.mp4"
)
REM Prompt the user
set /p "deleteFiles=Do you want to delete the residual files? (Y/N): "
if /i "%deleteFiles%"=="Y" (
    del /S *.mp3
    del /S *.jpg
    del /S *.png
    del /S *.exe
    del /S *.bat
) else (
    exit
)