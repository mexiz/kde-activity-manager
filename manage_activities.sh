#!/bin/bash

activity_names=("1" "2" "3" "4" "5")
hotkeys=("Alt+1" "Alt+2" "Alt+3" "Alt+4" "Alt+5")

create_activities() {
    activity_ids=$(kactivities-cli --list-activities | awk '{print $2}')

    for activity_name in "${activity_names[@]}"; do
        activity_exists=false

        for activity_id in $activity_ids; do
            activity_actual_name=$(kactivities-cli --activity-property name "$activity_id")

            if [ "$activity_actual_name" == "$activity_name" ]; then
                echo "Activity $activity_name already exists."
                activity_exists=true
                break
            fi
        done

        if [ "$activity_exists" = false ]; then
            kactivities-cli --create-activity "$activity_name"
            echo "Activity $activity_name created."
        fi
    done
}

remove_activities() {
    activity_ids=$(kactivities-cli --list-activities | awk '{print $2}')

    for activity_name in "${activity_names[@]}"; do
        for activity_id in $activity_ids; do
            activity_actual_name=$(kactivities-cli --activity-property name "$activity_id")
            if [ "$activity_actual_name" == "$activity_name" ]; then
                kactivities-cli --remove-activity "$activity_id"
                echo "Activity $activity_name (ID: $activity_id) has been removed."
                break
            fi
        done
    done
}

create_hotkeys() {
    activity_ids=$(kactivities-cli --list-activities | awk '{print $2}')

    for i in "${!activity_names[@]}"; do
        activity_name="${activity_names[$i]}"
        hotkey="${hotkeys[$i]}"

        for activity_id in $activity_ids; do
            activity_actual_name=$(kactivities-cli --activity-property name "$activity_id")

            if [ "$activity_actual_name" == "$activity_name" ]; then
                echo "Creating hotkey $hotkey for activity $activity_name (ID: $activity_id)"
                kwriteconfig5 --file ~/.config/kglobalshortcutsrc --group "ActivityManager" --key "switch-to-activity-$activity_id" "$hotkey,none,Switch to activity \"$activity_name\""
                break
            fi
        done
    done
    echo "Please Log Out to apply the changes."
}

if [ "$1" == "create" ]; then
    create_activities
elif [ "$1" == "remove" ]; then
    remove_activities
elif [ "$1" == "hotkeys" ]; then
    create_hotkeys
elif [ "$1" == "all" ]; then
    create_activities
    create_hotkeys
else
    echo "Usage: $0 {create|remove|hotkeys|all}"
fi
