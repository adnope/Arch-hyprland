#!/usr/bin/env bash

output_file=~/Media/screenshots/$(date +'%d_%m_%Y--%Hh%Mm%Ss_fullscreen.png')

grim -c "$output_file"
wl-copy < "$output_file"
notify-send -i "$output_file" "Screenshot copied to clipboard and saved to: $output_file"