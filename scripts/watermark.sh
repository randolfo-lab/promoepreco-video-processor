#!/usr/bin/env bash
set -euo pipefail

INPUT="${1:?input video required}"
OUTPUT="${2:?output video required}"
WATERMARK='https://promoepreco.shop/'
FONT='/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf'

if [[ ! -f "$INPUT" ]]; then
  echo "input_not_found" >&2
  exit 2
fi

# White text, black border/shadow, centered near the bottom, visible for the full video.
# Font size scales with video width while remaining inside a conservative range.
ffmpeg -hide_banner -loglevel warning -y \
  -i "$INPUT" \
  -vf "drawtext=fontfile=${FONT}:text='${WATERMARK}':fontcolor=white@0.82:borderw=3:bordercolor=black@0.72:shadowx=2:shadowy=2:shadowcolor=black@0.65:fontsize='max(24,min(48,w/24))':x=(w-text_w)/2:y=h-text_h-(h*0.055)" \
  -c:v libx264 -preset veryfast -crf 22 -pix_fmt yuv420p \
  -c:a aac -b:a 128k -movflags +faststart \
  "$OUTPUT"

ffprobe -v error -select_streams v:0 -show_entries stream=codec_name,width,height,duration -of json "$OUTPUT"
