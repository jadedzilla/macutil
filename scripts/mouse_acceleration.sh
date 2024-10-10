#!/bin/sh

. ./common.sh

# Get the current autohide status
current_status=$(defaults read NSGlobalDomain com.apple.mouse.linear)

if [ "$current_status" = "1" ]; then
    # If autohide is currently on, turn it off
    new_status=false
else
    # If autohide is currently off, turn it on
    new_status=true
fi

# Set the new autohide status
if defaults write NSGlobalDomain com.apple.mouse.linear -bool "$new_status"; then
    printf "${GREEN}Mouse acceleration toggled to %s${RC}\n" "$new_status"
    printf "${YELLOW}A restart for the change to take effect is required${RC}\n"
else
    printf "${RED}Failed to toggle mouse acceleration${RC}\n" >&2
    exit 1
fi