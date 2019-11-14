#!/bin/bash

# Video to GIF converter script by petmshall 2019
# Requires ffmpeg to run


echo "Creating gif "$2" from "$1"."

quality=$3

case "$quality" in
    0|lowest)
        maxwidth=80
        fps=10
        ;;
    1|lower)
        maxwidth=120
        fps=10
        ;;
    2|low)
        maxwidth=240
        fps=15
        ;;
    3|medium)
        maxwidth=360
        fps=15
        ;;
    4|high)
        maxwidth=480
        fps=20
        ;;
    5|highest)
        maxwidth=720
        fps=25
        ;;
    custom)
        maxwidth=$4
        fps=$5
        ;;
    *)
        echo "Usage: "$0" input output quality [width] [framerate]"
        echo "Quality selection:"
        echo "0 / lowest: 80p 10fps (Not recommended)"
        echo "1 / lower: 120p 10fps (Very fast to convert)"
        echo "2 / low: 240p 15fps (Recommended for internet use)"
        echo "3 / medium: 360p 15fps"
        echo "4 / high: 480p 20fps (More resources but acceptable)"
        echo "5 / highest: 720p 25fps (Not recommended)"
        echo "custom: Use for custom parameters"
        exit
        ;;
esac

rot=$(ffprobe -v error -select_streams v:0 -show_entries stream_tags=rotate -of csv=p=0 $1)
res=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 $1)
vx=${res%x*}
vy=${res#*x}
if [ "x"$rot == "x90" ] || [ "x"$rot == "x-90" ]; then
t=$vx
vx=$vy
vy=$t
fi
if [ $((vx)) -gt $((vy)) ]; then
x=$maxwidth
y=$((vy/(vx/x)/2*2))
else
y=$maxwidth
x=$((vx/(vy/y)/2*2))
fi

echo "Video converted from "$vx"x"$vy" to "$x"x"$y

mkdir .gifmaker

echo "Stage 1: Resizing video"
ffmpeg -i $1 -s "$x"x"$y" -r $fps -an .gifmaker/resized.mp4
echo "Stage 2: Generating pallette"
ffmpeg -i .gifmaker/resized.mp4 -filter_complex "[0:v] palettegen" .gifmaker/pallette.png
echo "Stage 3: Converting video"
ffmpeg -i .gifmaker/resized.mp4 -i .gifmaker/pallette.png -filter_complex "[0:v][1:v] paletteuse" -f gif $2

rm -r .gifmaker

echo "Done."
