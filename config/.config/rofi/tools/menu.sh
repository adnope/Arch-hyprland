#!/usr/bin/env bash

theme="
    @import \"~/.config/rofi/colors/may2025.rasi\"
    * {
        font: \"JetBrains Mono Nerd Font 14\";
    }
    mode-switcher {
        enabled: false;
    }
    window {
        width:                      400px;
        height:                     400px;
        border:                     0px;
        /* properties for all widgets */
        enabled:                    true;
        background-color:           transparent;
    }
    mainbox {
        enabled:                    true;
        spacing:                    10px;
        padding:                    10px 0px;
        border-color:               @selected;
        background-color:           @background;
        children:                   [ \"inputbar\", \"listview\"];
        border:                     3px solid;
        border-color:               @selected;
    }
    inputbar {
        padding:                    0px 0px 0px 10px;
        enabled:                    true;
        background-color:           transparent;
        text-color:                 @foreground;
        children:                   [ \"prompt\", \"entry\"];
    }
    prompt {
        enabled:                    true;
        background-color:           inherit;
        text-color:                 inherit;
    }
    entry {
        text-color:                 @foreground;
        cursor:                     text;
        spacing:                    0;
    }
    listview {
        enabled:                    true;
        scrollbar:                  false;
        background-color:           transparent;
        text-color:                 @foreground;
        border:                     0px;
    }
    element {
        enabled:                    true;
        spacing:                    10px;
        margin:                     0 0 0 -20px;
        background-color:           @background;
        text-color:                 @foreground;
    }
    element alternate.normal {
        background-color:           @background;
        text-color:                 @foreground;
    }
    element selected.normal {
        background-color:           @selected;
        text-color:                 @background;
    }
"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A ACTION=(
  [Audio]="$script_dir/audioswitch.sh"
  [Calculator]="$script_dir/calculator.sh"
  [Kill by name]="$script_dir/killprocess.sh"
  [Shutdown]="systemctl poweroff"
  [Reboot]="systemctl reboot"
  [Sleep]="systemctl suspend"
  [Hibernate]="systemctl hibernate"
  [Kill by clicking]="hyprctl kill"
)

modes=("${!ACTION[@]}")
choice=$(printf '%s\n' "${modes[@]}" \
         | sort \
         | rofi -dmenu -i -p "Tools: " -theme-str "$theme" \
         || exit 0)

cmd="${ACTION[$choice]}"
if [[ -n $cmd ]]; then
  $cmd
fi