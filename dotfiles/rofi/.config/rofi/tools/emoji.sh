#!/usr/bin/env bash

theme="
    @import \"~/.config/rofi/colors/may2025.rasi\"
    * {
        font: \"JetBrains Mono Nerd Font 12\";
    }
    mode-switcher {
        enabled: false;
    }
    window {
        width:                      800px;
        height:                     600px;
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
        padding:                    0px 0px 0px 15px;
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
        padding:                    0px 0px 0px 10px;
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

rofi -modi emoji -show emoji -emoji-mode insert -i -theme-str "$theme"