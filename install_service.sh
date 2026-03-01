#!/bin/bash

# Prompt for port number, defaulting to 7891
read -p "Enter port number for the Wyoming MLX Whisper service [default: 7891]: " PORT
PORT=${PORT:-7891}

# Validate that the port is a number in the valid range
if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
    echo "Error: '$PORT' is not a valid port number (must be 1-65535). Aborting."
    exit 1
fi

echo "Installing service on port $PORT..."

# Create log directory
mkdir -p "$PWD/log"
# Copy plist to LaunchAgents
cp com.wyoming_mlx_whisper.plist ~/Library/LaunchAgents/
# Replace <PWD-VARIABLE> and <PORT-VARIABLE> with actual values
sed -i '' \
    -e 's|<PWD-VARIABLE>|'"$PWD"'|g' \
    -e 's|<PORT-VARIABLE>|'"$PORT"'|g' \
    ~/Library/LaunchAgents/com.wyoming_mlx_whisper.plist
# Make the run script executable
chmod +x "$PWD/wyoming-mlx-whisper.sh"
# Remove any previous failed attempt
launchctl bootout gui/$(id -u)/com.wyoming_mlx_whisper.plist 2>/dev/null
# Load the service
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.wyoming_mlx_whisper.plist
echo "Service installed and started on tcp://localhost:$PORT"
