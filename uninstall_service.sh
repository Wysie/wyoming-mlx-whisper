#!/bin/bash

launchctl bootout gui/$(id -u)/com.wyoming_mlx_whisper.plist 2>/dev/null
rm -f ~/Library/LaunchAgents/com.wyoming_mlx_whisper.plist
