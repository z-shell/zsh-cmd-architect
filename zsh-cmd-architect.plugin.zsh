#!/usr/bin/env zsh

#
# No plugin manager is needed to use this file. All that is needed is adding:
#   source {where-znt-is}/zsh-cmd-architect.plugin.zsh
#
# to ~/.zshrc.
#

0="${(%):-%N}" # this gives immunity to functionargzero being unset
REPO_DIR="${0%/*}"
CONFIG_DIR="$HOME/.config/zca"

#
# Update FPATH if:
# 1. Not loading with Zplugin
# 2. Not having fpath already updated (that would equal: using other plugin manager)
#

if [[ -z "$ZPLG_CUR_PLUGIN" && "${fpath[(r)$REPO_DIR]}" != $REPO_DIR ]]; then
    fpath+=( "$REPO_DIR" )
fi

#
# Copy configs
#

if [[ ! -d "$HOME/.config" ]]; then
    command mkdir "$HOME/.config"
fi

if [[ ! -d "$CONFIG_DIR" ]]; then
    command mkdir "$CONFIG_DIR"
fi

unset __ZCA_CONFIG_FILE
typeset -g __ZCA_CONFIG_FILE
for __ZCA_CONFIG_FILE in "h-list.conf" "zca.conf"; do
    if [[ ! -f "$CONFIG_DIR/$__ZCA_CONFIG_FILE" ]]; then
        command cp "$REPO_DIR/.config/zca/$__ZCA_CONFIG_FILE" "$CONFIG_DIR"
    fi
done
unset __ZCA_CONFIG_FILE

#
# Load functions
#

autoload h-list zca zca-usetty-wrapper zca-widget
zle -N zca-widget
bindkey '^T' zca-widget
