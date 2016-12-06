#!/usr/bin/env bash

# Test whether or not the Xcode Command Line Tools are installed.
TOOLS_PATH=$(xcode-select --print-path 2>&1)

if [ ! "$?" -eq 0 ]; then
    error "The Xcode Command Line Tools are not yet installed. Aborting."

    xcode-select --install &> /dev/null
    exit 1
fi
