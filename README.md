# KDE Activity Manager

This project contains two Bash scripts to manage KDE activities and move windows between activities in the KDE Plasma environment.

## Scripts

1. **`manage_activities.sh`**: This script is used to create, remove, and manage hotkeys for activities.
2. **`mv_win_activity.sh`**: This script moves the currently active window to a specified activity.

## Requirements

Both scripts require the following:

- `kactivities-cli` – to manage KDE Plasma activities.
- `xdotool` – to identify the currently focused window.
- `xprop` – to modify window properties.

You can install the required packages with:

```bash
sudo apt install kactivities-cli xdotool xprop
```

## Installation

1. Copy both scripts to a directory of your choice.
2. Make the scripts executable by running:

   ```bash
   chmod +x manage_activities.sh
   chmod +x mv_win_activity.sh
   ```

## Usage

### 1. `manage_activities.sh`

This script manages KDE activities and hotkeys.

#### Syntax:

```bash
./manage_activities.sh {create|remove|hotkeys|all}
```

#### Commands:

- **`create`**: Creates the activities "1", "2", "3", "4", "5" if they do not already exist.
- **`remove`**: Removes these activities if they exist.
- **`hotkeys`**: Sets hotkeys (`Alt+1`, `Alt+2`, etc.) to switch between activities.
- **`all`**: Creates the activities and sets the hotkeys.

Example:

```bash
./manage_activities.sh create
```

### 2. `mv_win_activity.sh`

This script moves the currently active window to the specified activity.

#### Syntax:

```bash
./mv_win_activity.sh "Activity Name"
```

Example:

```bash
./mv_win_activity.sh "1"
```

If the window cannot be moved (e.g., it is `plasmashell`, or the activity is not found), the script will output an error message.

## Setting Up Keyboard Shortcuts

You can set up keyboard shortcuts to quickly run `mv_win_activity.sh` and move windows to specific activities:

1. Open **System Settings**.
2. Navigate to **Shortcuts** > **Custom Shortcuts**.
3. Right-click and select **New** -> **Global Shortcut** -> **Command/URL**.
4. Name the shortcut and set a key combination under the **Trigger** tab.
5. Under the **Action** tab, enter the path to the script followed by the activity name. For example:

   ```bash
   bash /path/to/mv_win_activity.sh "1"
   ```

6. Click **Apply**.

Now, you can use your keyboard shortcuts to move windows to different activities.