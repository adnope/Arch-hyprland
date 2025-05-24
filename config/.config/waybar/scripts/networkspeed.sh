#!/usr/bin/env bash

DEVICES=$(nmcli -t -f DEVICE,STATE,TYPE device |
    grep -w "connected" |
    grep -v -E "^(dummy|lo:|virbr0)" | awk -F: '{print $3}')

if [[ -z $DEVICES ]]; then
	echo -e "󱛅 No network"
	exit 1
fi

if [[ $DEVICES == *"ethernet"* && $DEVICES == *"wifi"* ]]; then
	INTERFACE=$(nmcli -t -f DEVICE,STATE,TYPE device | grep -w "connected" | grep -v -E "^(dummy|lo:|virbr0)" | grep "ethernet" | awk -F: '{print $1}')
	INTERFACE_TYPE="ethernet"
else
	INTERFACE=$(nmcli -t -f DEVICE,STATE,TYPE device | grep -w "connected" | grep -v -E "^(dummy|lo:|virbr0)" | grep "$DEVICES" | awk -F: '{print $1}')
	INTERFACE_TYPE="$DEVICES"
fi

down_start=$(grep $INTERFACE /proc/net/dev | awk '{print $2}')
up_start=$(grep $INTERFACE /proc/net/dev | awk '{print $10}')
sleep 1
down_end=$(grep $INTERFACE /proc/net/dev | awk '{print $2}')
up_end=$(grep $INTERFACE /proc/net/dev | awk '{print $10}')

read DOWN_RATE UP_RATE DOWN_UNIT UP_UNIT <<< $(awk -v ds="$down_start" -v de="$down_end" -v us="$up_start" -v ue="$up_end" '
BEGIN {
    down_rate = de - ds
    up_rate = ue - us
    
    if (down_rate >= 1048576) {
        down_rate /= 1048576
        down_unit = "MB/s"
		printf "%.2f ", down_rate
    } else if (down_rate >= 1024) {
        down_rate /= 1024
        down_unit = "KB/s"
		printf "%.2f ", down_rate
    } else {
        down_unit = "B/s"
		printf "%d ", down_rate
    }

	if (up_rate >= 1048576) {
        up_rate /= 1048576
        up_unit = "MB/s"
		printf "%.2f ", up_rate
    } else if (up_rate >= 1024) {
        up_rate /= 1024
        up_unit = "KB/s"
		printf "%.2f ", up_rate
    } else {
        up_unit = "B/s"
		printf "%d ", up_rate
    }
	printf "%s %s", down_unit, up_unit
}')

if [[ $INTERFACE_TYPE == "ethernet" ]]; then
	ICON=""
	IP=$(nmcli -e no -g ip4.address device show $INTERFACE)
	TOOLTIP=$(echo Ethernet connection"\r"Upload: ${ICON}  ${UP_RATE} ${UP_UNIT}"\r"IP: ${IP})
else
	signal=$(nmcli -t -f active,signal device wifi | grep "^yes" | awk -F: '{print $2}')
	if [[ "$signal" -ge 80 ]]; then
	  ICON="󰤨"
	elif [[ "$signal" -ge 60 ]]; then
	  ICON="󰤥"
	elif [[ "$signal" -ge 40 ]]; then
	  ICON="󰤢"
	elif [[ "$signal" -ge 20 ]]; then
	  ICON="󰤟"
	else
	  ICON="󰤯"
	fi
	IP=$(nmcli -e no -g ip4.address device show $INTERFACE)
	SSID=$(nmcli -t -f active,ssid device wifi | grep "^yes" | awk -F: '{print $2}')
	TOOLTIP=$(echo ${SSID}"\r"Upload: ${ICON}  ${UP_RATE} ${UP_UNIT}"\r"IP: ${IP})
fi

OUTPUT="${ICON}  ${DOWN_RATE} ${DOWN_UNIT}"
echo -e $OUTPUT"\n"$TOOLTIP
