#!/bin/bash

if [[ $1 == "On" ]]; then
	hyprsunset -t 4500
elif [[ $1 == "Off" ]]; then
	killall hyprsunset
fi