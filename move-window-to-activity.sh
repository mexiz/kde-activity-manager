#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please provide the name of the activity as an argument."
    exit 1
fi

activity_name="$1"

window_id=$(xdotool getwindowfocus)

window_info=$(xprop -id $window_id)

# Check if the current window is Plasmashell
if echo "$window_info" | grep -q "WM_CLASS(STRING) = \"plasmashell\", \"plasmashell\""; then
    echo "This is the Plasmashell. It should not be moved to another activity."
    exit 2
fi

output=$(qdbus --literal org.kde.ActivityManager /ActivityManager/Activities ListActivitiesWithInformation)

activity_id=$(echo "$output" | grep -oP "(?<=\[Argument: \(ssssi\) \")[^\"]+(?=\", \"$activity_name\")")

if [ -z "$activity_id" ]; then
    echo "Error: Activity not found."
    exit 2
else
    echo "$activity_id"
    xprop -f _KDE_NET_WM_ACTIVITIES 8s -id $window_id -set _KDE_NET_WM_ACTIVITIES $activity_id
    exit 0
fi
