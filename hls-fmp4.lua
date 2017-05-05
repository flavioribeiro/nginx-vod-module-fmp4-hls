require "string";

local HLS_LOCATION = "hlsts"
local DASH_LOCATION = "dash"
local HLS_FMP4_LOCATION = "hlsfmp4"

function get_init_segment_uri(host, uri)
  local init_segment_header = "#EXT-X-PLAYLIST-TYPE:VOD\n#EXT-X-MAP:URI="
  local init_segment_uri = "http://" .. host .. uri:gsub(HLS_FMP4_LOCATION, DASH_LOCATION):gsub("index","init"):gsub("m3u8", "mp4")
  return init_segment_header .. init_segment_uri
end

function get_audio_track(host, uri)
  local prefix, level = string.match(uri:gsub(".urlset", ""), "^(.-),(.-),")
	local audio_track_uri = "http://" .. host .. prefix .. level .. "p.mp4/index-a1-x3.m3u8"
	return '#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="aac",LANGUAGE="en",NAME="English",DEFAULT=YES,AUTOSELECT=YES,URI="' .. audio_track_uri .. '"\n'
end

ngx.header["Access-Control-Allow-Headers"] = '*';
ngx.header["Access-Control-Allow-Origin"] = '*';
ngx.header["Access-Control-Allow-Methods"] = 'GET, HEAD, OPTIONS';

hls_manifest = ngx.var.request_uri:gsub(HLS_FMP4_LOCATION, HLS_LOCATION)
hls_content = ngx.location.capture(hls_manifest)

if string.match(ngx.var.request_uri, "master.m3u8") then
	res, _ = hls_content.body:gsub(HLS_LOCATION, HLS_FMP4_LOCATION):gsub("a1.m3u8", "x3.m3u8")
  audio_track = get_audio_track(ngx.var.host, ngx.var.request_uri)
	res = res .. audio_track

elseif string.match(ngx.var.request_uri, "index") then
  init_segment = get_init_segment_uri(ngx.var.host, ngx.var.request_uri)
  res, _ = hls_content.body:gsub("EXT-%-X%-PLAYLIST%-TYPE:VOD", init_segment):gsub("%.ts","-x3.m4s"):gsub(HLS_LOCATION, DASH_LOCATION)
end

ngx.print(res)
