#!/bin/bash
status="$(playerctl status)"

if [[ -z "${status}" ]]; then
  exit
fi

if [[ "${status}" == Paused ]]; then
  printf '{"text": "%s", "class": "%s"}\n' "$(playerctl metadata title) - $(playerctl metadata artist)" paused
  exit
fi

if [[ "${status}" == Playing ]]; then
  printf '{"text": "%s", "class": "%s"}\n' "$(playerctl metadata title) - $(playerctl metadata artist)" playing
  exit
fi
