#!/bin/bash
fd -H -E "$(basename "$0")" -E .git -E LICENSE -E README.md -t f -x mkdir -p -v "${HOME}/{//}" \; -x ln -f -s -v "${PWD}/{}" "${HOME}/{}"
