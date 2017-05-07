# nginx-vod-module-fmp4-hls
This project aims to support some experiments around the playback of fragmented MP4’s on the [HTTP Live Streaming protocol](https://tools.ietf.org/html/draft-pantos-http-live-streaming-22).

It uses [Kaltura’s](http:’//kaltura.com) [nginx-vod-module](https://github.com/kaltura/nginx-vod-module) and [lua-nginx-module](https://github.com/openresty/lua-nginx-module)  to reuse m4s segments from the MPEG-Dash location by pointing the HLS manifests to them.

## Running
Assuming you have docker installed on your computer, clone the repository and go to the folder:

```
$ git clone https://github.com/flavioribeiro/nginx-vod-module-fmp4-hls.git && cd nginx-vod-module-fmp4-hls
```

Build a docker image from the `Dockerfile`:

```
$ docker build .
```

Now, get the docker `IMAGE ID` and spin up a new instance binding to your local port:

```
$ docker images
REPOSITORY                TAG                               IMAGE ID            CREATED             SIZE
<none>                    <none>                            4c064be1f291        12 minutes ago      296 MB
$ docker run -p 127.0.0.1:80:80 4c064be1f291
```

The nginx instance is [writing logs](https://github.com/flavioribeiro/docker-nginx-vod-module-fmp4-hls/blob/master/nginx.conf#L11-L12) on `stdout` to make it easier for debugging. You should be all set.

## Examples

### Drone

- H264/MP4 @ 360p: http://localhost/video/drone/drones360p.mp4
- H264/MP4 @ 480p: http://localhost/video/drone/drones480p.mp4
- H264/MP4 @ 720p: http://localhost/video/drone/drones720p.mp4
- H264/MP4 @ 1080p: http://localhost/video/drone/drones1080p.mp4
- HLS - H264/MPEG-TS: http://localhost/hlsts/drone/drones,360,480,720,1080,p.mp4.urlset/master.m3u8
- HLS - H264/fMP4: http://localhost/hlsfmp4/drone/drones,360,480,720,1080,p.mp4.urlset/master.m3u8

### Food

- H264/MP4 @ 360p: http://localhost/video/food/food360p.mp4
- H264/MP4 @ 480p: http://localhost/video/food/food480p.mp4
- H264/MP4 @ 720p: http://localhost/video/food/food720p.mp4
- H264/MP4 @ 1080p: http://localhost/video/food/food1080p.mp4
- HLS - H264/MPEG-TS: http://localhost/hlsts/food/food,360,480,720,1080,p.mp4.urlset/master.m3u8
- HLS - H264/fMP4: http://localhost/hlsfmp4/food/food,360,480,720,1080,p.mp4.urlset/master.m3u8

### Rocket

- H264/MP4 @ 360p: http://localhost/video/rocket/rocket360p.mp4
- H264/MP4 @ 480p: http://localhost/video/rocket/rocket480p.mp4
- H264/MP4 @ 720p: http://localhost/video/rocket/rocket720p.mp4
- H264/MP4 @ 1080p: http://localhost/video/rocket/rocket1080p.mp4
- HLS - H264/MPEG-TS: http://localhost/hlsts/rocket/rocket,360,480,720,1080,p.mp4.urlset/master.m3u8
- HLS - H264/fMP4: http://localhost/hlsfmp4/rocket/rocket,360,480,720,1080,p.mp4.urlset/master.m3u8

### Devito

- H264/MP4 @ 360p: http://localhost/video/devito/devito360p.mp4
- H264/MP4 @ 480p: http://localhost/video/devito/devito480p.mp4
- H264/MP4 @ 720p: http://localhost/video/devito/devito720p.mp4
- H264/MP4 @ 1080p: http://localhost/video/devito/devito1080p.mp4
- HLS - H264/MPEG-TS: http://localhost/hlsts/devito/devito,360,480,720,1080,p.mp4.urlset/master.m3u8
- HLS - H264/fMP4: http://localhost/hlsfmp4/devito/devito,360,480,720,1080,p.mp4.urlset/master.m3u8
- HLS - H264/MPEG-TS + Captions: http://localhost/hlsts/devito/devito,360p.mp4,480p.mp4,720p.mp4,1080p.mp4,.en_US.vtt,.urlset/master.m3u8

### Occupy 

- VP9/MP4 @ 1080p: http://localhost/video/vp9/occupy_vp9.mp4
- HLS - VP9/MPEG-TS: http://localhost/hlsts/vp9/occupy_vp9.mp4/master.m3u8 (broken)

## Playing the HLS examples 

You can playback the examples by using [hls.js](http://github.com/video-dev/hls.js) test page: http://video-dev.github.io/hls.js/demo/?src=[source_here]

## References

- https://bitmovin.com/hls-news-wwdc-2016/

- http://www.streamingmedia.com/Articles/News/Online-Video-News/HLS-Now-Supports-Fragmented-MP4-Making-it-Compatible-With-DASH-111796.aspx

- https://github.com/google/shaka-packager/issues/193
