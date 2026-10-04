#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="$HOME/.config/wallpapers"
mapfile -t MONITORS < <(hyprctl monitors -j | jq -r '.[].name')

# Pick one random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Apply wallpaper to each monitor
for MONITOR in "${MONITORS[@]}"; do
  hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER"
done
