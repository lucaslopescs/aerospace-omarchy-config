#!/bin/bash
# Launches the AeroSpace cheatsheet in a Chrome app window.
exec "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --app="file://$HOME/.config/aerospace/cheatsheet.html" \
  --window-size=880,880 \
  --user-data-dir="$HOME/.config/aerospace/chrome-profile"
