#!/usr/bin/env bash
# Writes the latest video of the channel playlist to data/youtube-latest.json
set -euo pipefail
cd "$(dirname "$0")/.."
PLAYLIST="UULF2zhmhsSvm6-tci5Rna1BIA"
curl -fsS "https://www.youtube.com/feeds/videos.xml?playlist_id=$PLAYLIST" -o /tmp/yt.xml
ID=$(grep -m1 -o '<yt:videoId>[^<]*' /tmp/yt.xml | sed 's/<yt:videoId>//')
[ -n "$ID" ] || { echo "no video found" >&2; exit 1; }
printf '{"id":"%s"}\n' "$ID" > data/youtube-latest.json
