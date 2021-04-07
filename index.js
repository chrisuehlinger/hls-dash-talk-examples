const path = require('path');
const os = require('os');
const { execSync } = require("child_process");
const NodeMediaServer = require('node-media-server');

// Figure out where ffmpeg is
let ffmpeg_path = execSync(os.platform() === 'win32' ? 'where ffmpeg' : 'which ffmpeg').toString();
// Remove the newline char(s) at the end
ffmpeg_path = ffmpeg_path.slice(0, os.platform() === 'win32' ? -2 : -1);

const config = {
  logType: 3,
  rtmp: {
    port: 1935,
    chunk_size: 60000,
    gop_cache: true,
    ping: 30,
    ping_timeout: 60
  },
  http: {
    port: 8000,
    allow_origin: '*',
    mediaroot: './livestreams',
    webroot: path.join(__dirname + '/public')
  },
  trans: {
    ffmpeg: ffmpeg_path,
    tasks: [
      {
        app: 'live',
        hls: true,
        hlsFlags: '[hls_time=2:hls_flags=round_durations:hls_segment_type=fmp4:hls_playlist_type=event]',
        dash: true,
        dashFlags: '[f=dash:seg_duration=2:window_size=3:extra_window_size=5]',
        // mp4: true,
        // mp4Flags: '[movflags=frag_keyframe+empty_moov]',
      }
    ]
  }
};
  
var nms = new NodeMediaServer(config)
nms.run();