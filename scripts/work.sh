#!/bin/bash

# Chrome profile (default to "Default" if not provided)
CHROME_PROFILE="${1:-Profile 1}"

echo "Starting work setup..."
echo "Using Chrome profile: $CHROME_PROFILE"

# Launch apps
open -a "Google Chrome" --args --profile-directory="$CHROME_PROFILE"
open -a "Microsoft Teams"
open -a "Terminal"
open -a "Docker"
open -a "IntelliJ IDEA"
open -a "Claude"
sleep 5

# Move Chrome, Teams, and Terminal to workspace A
aerospace list-windows --all | grep -i chrome | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} A 2>/dev/null
aerospace list-windows --all | grep -i teams | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} A 2>/dev/null
aerospace list-windows --all | grep -i terminal | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} A 2>/dev/null

# Set workspace A layout to accordion vertical
aerospace workspace A 2>/dev/null
aerospace layout accordion vertical

# Move Claude and IntelliJ to workspace 1
aerospace list-windows --all | grep -i claude | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} 1 2>/dev/null
aerospace list-windows --all | grep -i intellij | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} 1 2>/dev/null

# Set workspace 1 layout to tiles
aerospace workspace 1 2>/dev/null
aerospace layout tiles horizontal

# Move Docker to workspace 3 and minimize it
aerospace list-windows --all | grep -i docker | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} 3 2>/dev/null
osascript -e 'tell application "System Events" to set visible of process "Docker" to false'

# Start tmux session
tmux new-session -d -s work -n 'ngrok'
tmux send-keys -t work:ngrok 'ngrok http --url=bright-legal-spaniel.ngrok-free.app 8080' Enter

tmux new-window -t work -n 'twilio'
tmux send-keys -t work:twilio 'twilio dev-phone --phone-number +17098004089 --force' Enter

tmux new-window -t work -n 'gcloud'
tmux send-keys -t work:gcloud 'if gcloud auth application-default print-access-token &>/dev/null; then echo "gcloud already authenticated"; else gcloud auth application-default login; fi' Enter
