#!/bin/bash -ex

cd public
rm -fdr media
mkdir -p media
cd media

rm -fdr test-footage.mp4
ffmpeg -hide_banner -f lavfi -i testsrc=duration=60:size=1920x1080:rate=60 \
    -c:v libx264 -preset slow -b:v 1M -movflags frag_keyframe+empty_moov+default_base_moof -an test-footage.mp4 &

mkdir hls-recording
cd hls-recording
ffmpeg -hide_banner -f lavfi -i testsrc=duration=60:size=1920x1080:rate=60 \
    -c:v libx264 -preset slow -pix_fmt yuv420p -an \
    -f hls -hls_flags round_durations -hls_segment_type fmp4 -hls_time 2 -hls_playlist_type event stream.m3u8 &

wait
