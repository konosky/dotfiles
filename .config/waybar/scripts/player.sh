#!/bin/bash
if playerctl status &> /dev/null; then
  echo "$(playerctl metadata title) - $(playerctl metadata artist)"
fi
