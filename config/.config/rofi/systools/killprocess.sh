#!/usr/bin/env bash

theme="
    * {
        font: \"JetBrains Mono Nerd Font 12\";
        background:                 #1E2127FF;
        foreground:                 #FFFFFFFF;
        selected:                   #939AB7FF;
        foreground-alt:             rgba(255, 255, 255, 0.5);
    }
    configuration {
        kb-clear-line: \"Control+u\";
        kb-move-front: \"Control+a\";
        kb-move-end: \"Control+d\";
        kb-move-word-back: \"Control+Left\";
        kb-move-word-forward: \"Control+Right\";
        kb-move-char-back: \"Left\";
        kb-move-char-forward: \"Right\";
        kb-remove-word-back: \"Control+w,Control+BackSpace\";
        kb-remove-word-forward: \"Control+e,Control+Delete\";
        kb-remove-char-forward: \"Delete\";
        kb-remove-char-back: \"BackSpace\";
        kb-remove-to-eol: \"Control+End\";
        kb-remove-to-sol: \"Control+Home\";
    }
    mode-switcher {
        enabled: false;
    }
    window {
        border:                     0px;
        width:                      400px;
        height:                     400px;
        /* properties for all widgets */
        enabled:                    true;
        background-color:           transparent;
    }
    mainbox {
        enabled:                    true;
        spacing:                    10px;
        padding:                    10px;
        border-color:               @selected;
        background-color:           @background;
        children:                   [ \"inputbar\", \"message\", \"listview\"];
        border:                     2px solid;
        border-color:               @selected;
    }
    inputbar {
        enabled:                    true;
        background-color:           transparent;
        text-color:                 @foreground;
        children:                   [ \"textbox-prompt-colon\", \"entry\"];
    }
    prompt {
        enabled:                    true;
        background-color:           inherit;
        text-color:                 inherit;
    }
    textbox-prompt-colon {
        enabled:                    true;
        expand:                     false;
        str:                        \"Kill \";
        background-color:           inherit;
        text-color:                 inherit;
        padding: 0 10px 0 0;
    }
    entry {
        enabled:                    true;
        background-color:           inherit;
        text-color:                 @foreground-alt;
        cursor:                     text;
        placeholder:                \"Filter process...\";
        placeholder-color:          inherit;
    }
    message {
        border:                     0px;
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
        margin:                     0 0 0 -30px;
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

pid=$(ps -u $USER -o pid,comm,%cpu,%mem | rofi -dmenu -i -theme-str "$theme" -p Kill || exit 0 | awk '{print $1}')

if [[ -n $pid ]]; then
    kill -9 $pid
fi