#!/usr/bin/env bash

if [ "$#" -eq 2 ]; then
    MONITOR="$1" polybar --reload "$2" &
elif type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload "$1" &
  done
else
  polybar --reload "$1" &
fi

