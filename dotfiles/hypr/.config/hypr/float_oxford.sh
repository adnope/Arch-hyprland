#!/usr/bin/env bash

# A script to check if an oxford dictionary window is opened, then make it floating, resize and move to center

while true; do
    hyprctl clients -j | jq -c '.[]' | while read -r client; do
        title=$(echo "$client" | jq -r '.title')
        address=$(echo "$client" | jq -r '.address')
        is_floating=$(echo "$client" | jq -r '.floating')
        if [[ "$title" == https://www.oxfordlearnersdictionaries.com* && "$title" == *"Oxford Advanced Learner's Dictionary at OxfordLearnersDictionaries.com — Zen Browser" && "$is_floating" == "false" ]]; then
            hyprctl dispatch togglefloating address:$address
            sleep 0.05
            hyprctl dispatch focuswindow address:$address
            hyprctl dispatch resizeactive exact 800 900
            hyprctl dispatch centerwindow
            hyprctl dispatch focuswindow address:$address
        fi
    done
    sleep 0.05
done