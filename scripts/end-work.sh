#!/bin/bash

echo "Ending work session..."

# Close apps (suppress errors if user cancels or app prompts for unsaved changes)
osascript -e 'quit app "Google Chrome"' 2>/dev/null
osascript -e 'quit app "Microsoft Teams"' 2>/dev/null
osascript -e 'quit app "Docker"' 2>/dev/null
osascript -e 'quit app "Claude"' 2>/dev/null
osascript -e 'quit app "IntelliJ IDEA"' 2>/dev/null

# Send Ctrl+C to tmux windows to stop running processes
tmux send-keys -t work:ngrok C-c 2>/dev/null
tmux send-keys -t work:twilio C-c 2>/dev/null
tmux send-keys -t work:gcloud C-c 2>/dev/null

sleep 10

# Kill the tmux work session
tmux kill-session -t work 2>/dev/null

echo "Work session ended. Logging out..."

# Log out the user
osascript -e 'tell application "System Events" to log out'
