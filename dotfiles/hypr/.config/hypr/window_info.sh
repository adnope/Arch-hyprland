#!/usr/bin/env bash

info=$(hyprctl activewindow)
zenity --title="Window information" --info --no-wrap --text="$info"
