#!/bin/sh
printf '\033c\033]0;%s\a' TheReactor
base_path="$(dirname "$(realpath "$0")")"
"$base_path/TheReactor.x86_64" "$@"
