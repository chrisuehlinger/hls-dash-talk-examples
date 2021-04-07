# We’re Doing It Live! Broadcasting on the Web with HLS and DASH

## Get Started

Make sure you have ffmpeg installed (index.js will find it) and use `npm install` to install all the dependencies. Once you've done that:

- `npm run start:static` will start the static webserver, go visit http://localhost:8712
- `npm start` will start the streaming server, go visit http://localhost:8000 (If you're running this you don't need the static server)

To stream video to this thing, go into OBS > Settings > Stream and enter rtmp://localhost/live as your Server and my-stream as your Stream Key. Then close settings and hit "Start Streaming". The logs should indicate that the server is receiving your stream. At that point, go to http://localhost:8000/04-hls.html to view your stream.

