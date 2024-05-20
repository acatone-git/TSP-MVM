@echo off
echo #--------------------------------------#
echo - TrimUI Smart Pro - Music Video Maker -
echo #--------------------------------------#
echo Converting Cover Image...
for %%f in (*.jpg *.png) do (
    ffmpeg -loglevel panic -i "%%f" -y -vf "scale=640:360:force_original_aspect_ratio=decrease,pad=640:360:-1:-1:color=black" "cover.jpg"
)
echo Converting Audio to Video...
for %%G in (*.mp3 *.ogg *.flac *.wav) do (
    ffmpeg -loglevel panic -y -loop 1 -i cover.jpg -i "%%G" -c:v libx264 -tune stillimage -c:a mp3 -pix_fmt yuv420p -shortest "%%~nG.mp4"
)
echo #--------------------------------------#
echo ---------- Final Cleanup ---------------
echo #--------------------------------------#
REM Prompt the user
set /p "deleteFiles=Keep only the MP4 files (Y/N): "
if /i "%deleteFiles%"=="Y" (
  del /S *.mp3 *.ogg *.flac *.wav *.jpg *.png *.exe *.bat
) else (
    exit
)
