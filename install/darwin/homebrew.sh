#!/usr/bin/env bash

# Test whether or not Homebrew is installed.
if test ! $(which brew); then
    printf "${COLOR_BLUE}Installing Homebrew...${ANSI_RESET}\n"

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || true

    printf "${COLOR_GREEN}Finished installing Homebrew.${ANSI_RESET}\n"
else
    printf "${COLOR_YELLOW}Homebrew is already installed.${ANSI_RESET}\n"
fi
