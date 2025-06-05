#!/usr/bin/env bash

region=$(slurp)
[ -z "$region" ] && exit 1

tmp_output_file=$(mktemp --suffix=.png)
grim -c -g "$region" - | swappy -f - -o $tmp_output_file
wl-copy < "$tmp_output_file"
notify-send -i "$tmp_output_file" "Screenshot copied to clipboard"

rm "$tmp_output_file"