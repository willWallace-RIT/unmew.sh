#!/usr/bin/env bash

while true; do
    pactl list sink-inputs | awk '
    /Sink Input #/ {gsub("#","",$3); id=$3}
    /application.process.binary = "chromium"/ ||
    /application.process.binary = "chrome"/ ||
    /application.name = "Chromium"/ {
        print id
    }' | while read -r id; do
        if [[ -n "$id" ]]; then
            pactl set-sink-input-mute "$id" 0
            echo "Unmuted Chromium audio stream: $id"
        fi
    done

    sleep 2
done