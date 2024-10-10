#!/bin/sh

if defaults write com.apple.dock "autohide-delay" -float "0" && killall Dock; then
    printf "%s\n" "Dock autohide set to 0"
else
    printf "%s\n" "Failed to set Dock autohide" >&2
    exit 1
fi