#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please provide the name of the activity as an argument."
    exit 1
fi

activity_name="$1"

output=$(qdbus --literal org.kde.ActivityManager /ActivityManager/Activities ListActivitiesWithInformation)

activity_id=$(echo "$output" | grep -oP "(?<=\[Argument: \(ssssi\) \")[^\"]+(?=\", \"$activity_name\")")

if [ -z "$activity_id" ]; then
    echo "Error: Activity not found."
    exit 2
else
    echo "$activity_id"
    xprop -f _KDE_NET_WM_ACTIVITIES 8s -id $(xdotool getwindowfocus) -set _KDE_NET_WM_ACTIVITIES $activity_id
    exit 0
fi
