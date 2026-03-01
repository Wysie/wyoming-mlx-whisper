#!/bin/bash

# Create log directory
mkdir -p "$PWD/log"

# Copy plist to LaunchAgents
cp com.wyoming_mlx_whisper.plist ~/Library/LaunchAgents/

# Replace <PWD-VARIABLE> with actual path
sed -i '' -e 's|<PWD-VARIABLE>|'"$PWD"'|g' ~/Library/LaunchAgents/com.wyoming_mlx_whisper.plist

# Make the run script executable
chmod +x "$PWD/wyoming-mlx-whisper.sh"

# Remove any previous failed attempt
launchctl bootout gui/$(id -u)/com.wyoming_mlx_whisper.plist 2>/dev/null

# Load the service
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.wyoming_mlx_whisper.plist
