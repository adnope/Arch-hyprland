#!/usr/bin/env bash

theme="
    * {
        font: \"JetBrains Mono Nerd Font 12\";
        background:                 #1E2127FF;
        foreground:                 #FFFFFFFF;
        selected:                   #939AB7FF;
    }
    mode-switcher {
        enabled: false;
    }
    window {
        width:                      200px;
        height:                     200px;
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
        border:                     2px solid;
        border-color:               @selected;
    }
    inputbar {
        padding:                    0px 0px 0px 20px;
        enabled:                    true;
        background-color:           transparent;
        text-color:                 @foreground;
        children:                   [ \"prompt\"];
    }
    prompt {
        font: \"JetBrains Mono Nerd Font Bold 14\";
        enabled:                    true;
        background-color:           inherit;
        text-color:                 inherit;
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

choice=$(echo -e "Audio\nCalculator\nKill" | rofi -dmenu -p "System tools" -theme-str "$theme" || exit 0)

script_dir="$HOME/.config/rofi/systools"

case "$choice" in
    Audio)
        command $script_dir/audioswitch.sh
        ;;
    Calculator)
        command $script_dir/calculator.sh
        ;;
    Kill)
        command $script_dir/killprocess.sh
        ;;
esac