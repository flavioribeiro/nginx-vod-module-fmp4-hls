FROM fsouza/nginx-vod-module:1.11.10-1.16

ADD video /opt/static/video
COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY hls-fmp4.lua /usr/local/nginx/conf/hls-fmp4.lua
EXPOSE 80
