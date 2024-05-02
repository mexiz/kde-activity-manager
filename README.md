# Move Window to Activity

This script allows you to move the currently active window to a specified KDE Plasma activity.

## Requirements

- `qdbus` - for communicating with KDE's D-Bus.
- `xdotool` - to identify the currently focused window.
- `xprop` - to modify window properties.

```bash
sudo apt install qdbus xdotool xprop
```

## Installation

1. Copy the script to a directory of your choice.
2. Make the script executable:

```bash
chmod +x move-window-to-activity.sh
```

## Usage

To use the script, you need to run it with the name of the target activity as an argument:

```bash
./move-window-to-activity.sh "Activity Name"
```

If no activity with the specified name is found, the script will output an error.

## Setting a Keyboard Shortcut

To execute the script using a keyboard shortcut in **Kubuntu**, follow these steps:

1. Go to **System Settings**.
2. Navigate to **Shortcuts**.
3. Select **Custom Shortcuts**.
4. Right Click **New** -> **Global Shortcut** -> **Command/URL**.
5. Name your shortcut and provide a description.
6. Under the **Trigger** tab, set the desired key combination.
7. In the **Action** tab, enter the path to the script followed by the activity name without the quotes. For example:
   ```bash
   bash /path/to/move-window-to-activity.sh "Activity-name"
   ```
8. Apply the changes.

Now, you can activate the script using the keyboard shortcut you set.