#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

#!/bin/bash

APP="${INFO:-}"

# Fallback if INFO is empty (rare; depends on your event source)
if [ -z "$APP" ]; then
  APP="$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)"
fi

icon_for_app() {
  case "$1" in
    # Terminals
    "Terminal"|"Ghostty") echo "􀪏" ;;

    # Browsers
    "Safari"|"Google Chrome"|"Zen") echo "􀎭" ;;

    # Music / media
    "NetEaseMusic") echo "􀑪" ;;

    # Finder / system
    "Finder") echo "􀈕" ;;
    "System Settings") echo "􀍟" ;;
    "App Store") echo "􀋑" ;;
    "Mail") echo "􀍜" ;;
    "Messages") echo "􀌤" ;;
    "Calendar") echo "􀉉" ;;
    "Notes") echo "􀉄" ;;

    # Default
    *) echo "􁹜" ;;
  esac
}

ICON="$(icon_for_app "$APP")"

# You can show label or not. If you only want icon, set label="".
sketchybar --set front_app icon="$ICON" label="$APP"
