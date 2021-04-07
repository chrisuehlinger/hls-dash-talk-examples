#!/bin/bash -ex


cd public
rm -fdr media
mkdir media
cd media

ffmpeg -f lavfi -i testsrc=duration=60:size=1920x1080:rate=60 \
    -c:v libx264 -preset slow -an test-footage.mp4

mkdir chopped-mp4
cd chopped-mp4
for n in $(seq 0 1 59); do
    echo $n
    ffmpeg -f lavfi -i testsrc=duration=60:size=1920x1080:rate=60 \
        -ss $n -t 1 -c:v libx264 -preset slow -an "test-footage-${n}.mp4"
done
cd ..

mkdir hls-recording
cd hls-recording
ffmpeg -f lavfi -i testsrc=duration=60:size=1920x1080:rate=60 \
    -c:v libx264 -preset slow -an -f hls -hls_time 1 -hls_playlist_type event stream.m3u8
