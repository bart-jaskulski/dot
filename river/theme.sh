#!/bin/sh

# Minimal Dark Theme with BB-Pod Amber Accent
# Base: Dark Blue-Grey
# Accent: Warm Amber/Orange-Yellow

# Palette
bg0="#1a1b26" # Dark Background
bg1="#24283b" # Slightly Lighter BG / Borders
bg2="#414868" # UI Elements / Selection BG
fg0="#c0caf5" # Primary Foreground
fg1="#a9b1d6" # Secondary Foreground
fg_dark="#565f89" # Darker Foreground / Comments

# accent="#73daca" # Old Cyan/Teal Accent
accent="#ffb86c" # BB-Pod Amber/Orange-Yellow Accent <= CHANGED
urgent="#f7768e" # Muted Coral/Red for Urgency/Errors

# River colors
riverctl border-color-focused "$accent"
riverctl border-color-unfocused "$bg1"
riverctl border-color-urgent "$urgent"

# Set border width
riverctl border-width 2
