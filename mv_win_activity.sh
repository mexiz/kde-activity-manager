#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please provide the name of the activity as an argument."
    exit 1
fi

activity_name="$1"

if command -v xdotool &> /dev/null; then
    window_id=$(xdotool getwindowfocus)
else
    echo "Error: xdotool is not installed. Please install it."
    exit 1
fi

window_info=$(xprop -id $window_id)

if echo "$window_info" | grep -q "WM_CLASS(STRING) = \"plasmashell\", \"plasmashell\""; then
    echo "This is the Plasmashell. It should not be moved to another activity."
    exit 2
fi

activity_ids=$(kactivities-cli --list-activities | awk '{print $2}')

for activity_id in $activity_ids; do
    activity_actual_name=$(kactivities-cli --activity-property name "$activity_id")
    
    if [ "$activity_actual_name" == "$activity_name" ]; then
        echo "Found activity $activity_name with ID $activity_id"
        xprop -f _KDE_NET_WM_ACTIVITIES 8s -id $window_id -set _KDE_NET_WM_ACTIVITIES $activity_id
        echo "Moved window to activity $activity_name (ID: $activity_id)"
        exit 0
    fi
done

echo "Error: Activity '$activity_name' not found."
exit 2
