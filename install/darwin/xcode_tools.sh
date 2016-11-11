#!/usr/bin/env bash

# Test whether or not the Xcode Command Line Tools are installed.
TOOLS_PATH=$(xcode-select --print-path 2>&1)

if [ ! "$?" -eq 0 ]; then
    printf "${COLOR_RED}The Xcode Command Line Tools are not yet installed. Aborting.${ANSI_RESET}\n"

    xcode-select --install &> /dev/null
    exit 1
else
    printf "${COLOR_YELLOW}The Xcode Command Line Tools are already installed.${ANSI_RESET}\n"
fi
