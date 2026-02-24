#!/bin/bash

echo "Starting work setup..."

# Launch apps
open -a "Google Chrome" --args --profile-directory="Default"
open -a "Microsoft Teams"
open -a "Terminal"
open -a "Docker"
open -a "Claude"
open -a "IntelliJ IDEA"
sleep 5

# Move Chrome, Teams, and Terminal to workspace C
aerospace list-windows --all | grep -i chrome | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} C
aerospace list-windows --all | grep -i teams | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} C
aerospace list-windows --all | grep -i terminal | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} C

# Set workspace C layout to accordion horizontal
aerospace workspace C
aerospace layout accordion horizontal

# Move Claude and IntelliJ to workspace 1
aerospace list-windows --all | grep -i claude | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} 1 2>/dev/null
aerospace list-windows --all | grep -i intellij | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} 1 2>/dev/null

# Move Docker to workspace 3 and minimize it
aerospace list-windows --all | grep -i docker | awk '{print $1}' | head -1 | xargs -I{} aerospace move-node-to-workspace --window-id {} 3
osascript -e 'tell application "System Events" to set visible of process "Docker" to false'

# Start tmux session
tmux new-session -d -s work -n 'ngrok'
tmux send-keys -t work:ngrok 'ngrok http --url=bright-legal-spaniel.ngrok-free.app 8080' Enter

tmux new-window -t work -n 'twilio'
tmux send-keys -t work:twilio 'twilio dev-phone' Enter

tmux new-window -t work -n 'gcloud'
tmux send-keys -t work:gcloud 'gcloud auth application-default login' Enter
