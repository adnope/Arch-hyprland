#! /usr/bin/env bash
set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A WEATHER_ICONS=(
    ["113"]="☀️"
    ["116"]="⛅️"
    ["119"]="☁️"
    ["122"]="☁️"
    ["143"]="🌫"
    ["176"]="🌦"
    ["179"]="🌧"
    ["182"]="🌧"
    ["185"]="🌧"
    ["200"]="⛈"
    ["227"]="🌨"
    ["230"]="❄️"
    ["248"]="🌫"
    ["260"]="🌫"
    ["263"]="🌦"
    ["266"]="🌦"
    ["281"]="🌧"
    ["284"]="🌧"
    ["293"]="🌦"
    ["296"]="🌦"
    ["299"]="🌧"
    ["302"]="🌧"
    ["305"]="🌧"
    ["308"]="🌧"
    ["311"]="🌧"
    ["314"]="🌧"
    ["317"]="🌧"
    ["320"]="🌨"
    ["323"]="🌨"
    ["326"]="🌨"
    ["329"]="❄️"
    ["332"]="❄️"
    ["335"]="❄️"
    ["338"]="❄️"
    ["350"]="🌧"
    ["353"]="🌦"
    ["356"]="🌧"
    ["359"]="🌧"
    ["362"]="🌧"
    ["365"]="🌧"
    ["368"]="🌨"
    ["371"]="❄️"
    ["374"]="🌧"
    ["377"]="🌧"
    ["386"]="⛈"
    ["389"]="🌩"
    ["392"]="⛈"
    ["395"]="❄️"
)

# Put your weatherapi.com API key in this variable
API_KEY=$(cat "$SCRIPT_DIR"/ignore/weather_api_key.env)
QUERY="Hanoi"

json_response=$(curl -s "http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$QUERY")

icon_url=$(jq -r '.current.condition.icon' <<< $json_response)
icon_code=${icon_url##*/}
icon_code=${icon_code%%.*}

ICON="${WEATHER_ICONS[$icon_code]:-❓}"
TEMP_C=$(jq -r '.current.temp_c' <<< $json_response)

LOCATION=$(jq -r '.location.name' <<< $json_response)/$(jq -r '.location.country' <<< $json_response)
CONDITION_TEXT=$(jq -r '.current.condition.text' <<< $json_response)
TEMP_FEELSLIKE=$(jq -r '.current.feelslike_c' <<< $json_response)\

echo -e "$ICON $TEMP_C°C\n$LOCATION: $CONDITION_TEXT, Feels like: $TEMP_FEELSLIKE°C"