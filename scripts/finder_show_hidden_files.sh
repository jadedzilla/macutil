#!/bin/sh

. ./common.sh

# Get the current autohide status
current_status=$(defaults read com.apple.finder "AppleShowAllFiles")

if [ "$current_status" = "1" ]; then
    # If autohide is currently on, turn it off
    new_status=false
else
    # If autohide is currently off, turn it on
    new_status=true
fi

# Set the new autohide status
if defaults write com.apple.finder "AppleShowAllFiles" -bool "$new_status" && killall Finder; then
    printf "${GREEN}Show all files in Finder toggled to %s${RC}\n" "$new_status"
else
    printf "${RED}Failed to toggle show all files in Finder${RC}\n" >&2
    exit 1
fi