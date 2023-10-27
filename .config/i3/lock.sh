#!/usr/bin/env bash

if [ -f "$HOME/code/i3-wm-scripts/i3lock.sh" ]; then
    "$HOME/code/i3-wm-scripts/i3lock.sh" "$@"
    if [ -f "$HOME/.local/bin/tvhdmi" ]; then
        "$HOME/.local/bin/tvhdmi"
    fi
else
    i3lock
fi
