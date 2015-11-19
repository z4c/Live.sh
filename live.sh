#!/bin/bash
#
# Watches the folder or files passed as arguments to the script and when it
# detects a change it automatically refreshes the current selected chromium tab or
# window.
#
# Usage:
# ./live.sh /folder/to/watch /some/folder/file_to_watch.html

TIME_FORMAT='%F %H:%M'
OUTPUT_FORMAT='%T Event(s): %e fired for file: %w. Refreshing.'

while inotifywait -q -r -e modify --timefmt "${TIME_FORMAT}" --format "${OUTPUT_FORMAT}" "$@"; do
    CHROME_WINDOW=`xdotool search --onlyvisible --class chromium-browser | head -1`
    ACTIVE_WINDOW=`xdotool getactivewindow`
    xdotool windowactivate $CHROME_WINDOW key 'CTRL+r'
    xdotool windowactivate $ACTIVE_WINDOW
done
