#!/usr/bin/env bash

# Test whether or not the Xcode Command Line Tools are installed.
if ! type xcode-select >&- && xpath=$(xcode-select --print-path 2>&1) && test -d "${xpath}" && test -x "${xpath}"; then
    printf "${COLOR_RED}The ${FONT_BOLD_ON}Xcode Command Line Tools${FONT_BOLD_OFF} are not yet installed. Aborting.${ANSI_RESET}\n"

    xcode-select --install &> /dev/null
    exit 1
fi
