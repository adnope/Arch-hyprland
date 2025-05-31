#!/usr/bin/env bash

rofi_theme="
    @import \"~/.config/rofi/colors/may2025.rasi\"
    * {
        font: \"JetBrains Mono Nerd Font 14\";
    }
    mode-switcher {
        enabled: false;
    }

    window {
        background-color: transparent;
        border: 0px;
        width: 200px;
        height: 130px;
    }
    mainbox {
        enabled: true;
        border-color: @selected;
        background-color: @background;
        children: [ "inputbar", "listview" ];
        border: 3px solid;
        border-radius: 0px;
        border-color: @selected;
    }

    inputbar {
        enabled: true;
        padding: 10px;
        background-color: transparent;
        text-color: @foreground;
        children: [ "dummy", "prompt", "dummy" ];
    }
    prompt {
        font: \"Jetbrains Mono Nerd Font Bold 16\";
        background-color: inherit;
        text-color: @foreground;
    }

    listview {
        border: 0px;
        background-color: transparent;
        scrollbar: false;
    }
    element {
        background-color: transparent;
    }
    element selected.normal {
        background-color: @selected;
        text-color: @background;
    }
    element alternate.normal {
        background-color: transparent;
    }
    element-text {
        background-color: transparent;
        text-color: inherit;
        highlight: inherit;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.35;
    }
"

tmp_screenshot_file=$(mktemp --suffix=.png)
output_file=~/Pictures/Screenshots/$(date +'%d_%m_%Y--%Hh%Mm%Ss_swappy.png')
grim -c "$tmp_screenshot_file"

choice=$(echo -e "No\nYes" | rofi -dmenu -p "Annotate?" -theme-str "$rofi_theme" || exit 0)

if [[ $choice == Yes ]]; then
    swappy -f "$tmp_screenshot_file" -o $output_file
    wl-copy < "$output_file"
    notify-send -i "$output_file" "Fullscreen screenshot copied to clipboard and saved to: $output_file"
else
    wl-copy < "$tmp_screenshot_file"
    cp "$tmp_screenshot_file" "$output_file"
    notify-send -i "$output_file" "Fullscreen screenshot copied to clipboard and saved to: $output_file"
fi

rm "$tmp_screenshot_file"