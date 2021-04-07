#!/bin/bash -ex


cd public
# rm -fdr media
mkdir -p media
cd media

rm -fdr test-footage.mp4
ffmpeg -hide_banner -f lavfi -i testsrc=duration=60:size=1920x1080:rate=60 \
    -c:v libx264 -preset slow -pix_fmt yuv420p -profile:v baseline -level:v 3.0 -b:v 1M \
    -color_range tv -colorspace smpte170m -color_primaries smpte170m -color_trc bt709 \
    -movflags frag_keyframe+empty_moov+default_base_moof -an test-footage.mp4

# mkdir hls-recording
# cd hls-recording
# ffmpeg -hide_banner -f lavfi -i testsrc=duration=60:size=1920x1080:rate=60 \
#     -c:v libx264 -preset slow -pix_fmt yuv420p -an -f hls -hls_time 1 -hls_playlist_type event stream.m3u8

wait
