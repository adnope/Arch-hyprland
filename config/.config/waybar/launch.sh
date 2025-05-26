#!/bin/bash

killall -9 waybar
waybar -c ~/.config/waybar/bar1/config.jsonc -s ~/.config/waybar/bar1/style.css &