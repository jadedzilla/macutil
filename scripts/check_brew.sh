#!/bin/sh

# Check if Homebrew is installed
if command -v brew >/dev/null 2>&1; then
    printf "Homebrew is installed.\n"
    printf "Checking Homebrew version...\n"
    version=$(brew --version)
    printf "\033[1A\033[K"  # Move cursor up and clear the line
    printf "%s\n" "$version"
else
    printf "Homebrew is not installed.\n"
    printf "Would you like to install Homebrew? (y/n): "
    read -r answer
    case "$answer" in
        [Yy]*)
            printf "Installing Homebrew...\n"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            if [ $? -eq 0 ]; then
                printf "Homebrew has been successfully installed.\n"
            else
                printf "Failed to install Homebrew. Please visit https://brew.sh for manual installation.\n"
            fi
            ;;
        *)
            printf "Homebrew installation skipped. You can install it later by visiting: https://brew.sh\n"
            ;;
    esac
fi
