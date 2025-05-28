#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
API_KEY=$(<"$SCRIPT_DIR"/ignore/weather_api_key.env)
LOCATION="Hanoi"

declare -A ICONS=(
  ["113"]="☀️" ["116"]="⛅️" ["119"]="☁️" ["122"]="☁️" ["143"]="🌫"
  ["176"]="🌦" ["179"]="🌧" ["182"]="🌧" ["185"]="🌧" ["200"]="⛈"
  ["227"]="🌨" ["230"]="❄️" ["248"]="🌫" ["260"]="🌫" ["263"]="🌦"
  ["266"]="🌦" ["281"]="🌧" ["284"]="🌧" ["293"]="🌦" ["296"]="🌦"
  ["299"]="🌧" ["302"]="🌧" ["305"]="🌧" ["308"]="🌧" ["311"]="🌧"
  ["314"]="🌧" ["317"]="🌧" ["320"]="🌨" ["323"]="🌨" ["326"]="🌨"
  ["329"]="❄️" ["332"]="❄️" ["335"]="❄️" ["338"]="❄️" ["350"]="🌧"
  ["353"]="🌦" ["356"]="🌧" ["359"]="🌧" ["362"]="🌧" ["365"]="🌧"
  ["368"]="🌨" ["371"]="❄️" ["374"]="🌧" ["377"]="🌧" ["386"]="⛈"
  ["389"]="🌩" ["392"]="⛈" ["395"]="❄️"
)

response=$(curl -s "http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$LOCATION")

temp_c=$(jq -r '.current.temp_c' <<<"$response")
feels_like=$(jq -r '.current.feelslike_c' <<<"$response")
condition_text=$(jq -r '.current.condition.text' <<<"$response")
icon_url=$(jq -r '.current.condition.icon' <<<"$response")
city=$(jq -r '.location.name' <<<"$response")
country=$(jq -r '.location.country' <<<"$response")

# extract the 3-digit code from the URL, e.g. ".../176.png" → "176"
code_from_url=${icon_url##*/}   # strips everything up to last "/"
code_from_url=${code_from_url%.png}  # strips the ".png"

icon="${ICONS[$code_from_url]}"
[ -z "$icon" ] && icon="❓"

echo "$icon ${temp_c}°C"
echo "${city}/${country}: ${condition_text}, Feels like: ${feels_like}°C"