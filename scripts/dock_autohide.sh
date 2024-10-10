#!/bin/sh

# Get the current autohide status
current_status=$(defaults read com.apple.dock autohide)

if [ "$current_status" = "1" ]; then
    # If autohide is currently on, turn it off
    new_status=false
else
    # If autohide is currently off, turn it on
    new_status=true
fi

# Set the new autohide status
if defaults write com.apple.dock autohide -bool "$new_status" && killall Dock; then
    printf "Dock autohide toggled to %s\n" "$new_status"
else
    printf "Failed to toggle Dock autohide\n" >&2
    exit 1
fi
