#!/usr/bin/env bash

export FZF_DEFAULT_OPTS="--height=100% --layout=reverse --no-sort --prompt=\"~ \" --color=dark,hl:red:regular,fg+:white:regular,hl+:red:regular:reverse,query:white:regular,info:gray:regular,prompt:red:bold,pointer:red:bold"

base=$(cat ./scripts/cmd | fzf | cat)
case $base in
    "check") ./scripts/alejandra -c . ;;
    "format") ./scripts/alejandra . ;;
    "deploy") ./scripts/deploy.sh ;;
    "rebuild") ./scripts/rebuild.sh ;;
    esac
# For st instead
# st -c fzf-menu -n fzf-menu -e bash -c "fzf-tmux -m $* < /proc/$$/fd/0 | awk 'BEGIN {ORS=\" \"} {print}' > /proc/$$/fd/1"
