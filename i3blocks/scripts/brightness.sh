#!/usr/bin/env bash

if [[ "$1" == "up" ]]; then
  brightnessctl set 5%+ > /dev/null 2>&1
  echo ""
  exit 0
elif [[ "$1" == "down" ]]; then
  brightnessctl set 5%- > /dev/null 2>&1
  echo ""
  exit 0
else
  brightnessctl | grep -oP '(?<=\()[0-9]+(?=%)' | tr -d '[:space:]'
fi

