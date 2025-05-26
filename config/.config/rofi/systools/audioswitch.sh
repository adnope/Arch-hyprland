#!/usr/bin/env bash
# Set audio sinks before using!
# `pactl list sinks` if on pulseaudio.

rofi_theme="
* {
    font: \"JetBrains Mono Nerd Font 12\";
    background: #1E2127FF;
    foreground: #FFFFFFFF;
    selected: #939AB7FF;
}
mode-switcher {
    enabled: false;
}

window {
    background-color: transparent;
    border: 0px;
    width: 250px;
    height: 150px;
}
mainbox {
    enabled: true;
    border-color: @selected;
    background-color: @background;
    children: [ "inputbar", "listview" ];
    border: 2px solid;
    border-radius: 0px;
    border-color: @selected;
}

inputbar {
    enabled: true;
    padding: 10px 20px;
    background-color: transparent;
    text-color: @foreground;
    children: [ "prompt" ];
}
prompt {
    font: \"Jetbrains Mono Nerd Font Bold 14\";
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
}"

choosespeakers() { \
    choice=$(echo -e "Speakers\nHeadphones\nBluetooth" | rofi -dmenu -p "Choose your audio" -theme-str "$rofi_theme" || exit 0)
    case "$choice" in
        Headphones) keyword="usb";;
        Speakers) keyword="pci";;
        Bluetooth) keyword="bluez";;
    esac

    if [[ -z $keyword ]]; then
        exit 0
    fi

    sink=$(pactl list sinks short | grep "$keyword" | awk '{print $1}')
    source=$(pactl list sources short | grep "input" | grep "$keyword" | awk '{print $1}')

    pactl set-default-sink "$sink" &
    pactl set-default-source "$source" &
    notify-send "Audio switched to $choice!"
}

choosespeakers