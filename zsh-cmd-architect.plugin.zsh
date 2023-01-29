#!/usr/bin/env zsh

#
# No plugin manager is needed to use this file. All that is needed is adding:
#   source {where-znt-is}/zsh-cmd-architect.plugin.zsh
#
# to ~/.zshrc.
#

0="${(%):-%N}" # this gives immunity to functionargzero being unset

# https://wiki.zshell.dev/community/zsh_plugin_standard#standard-plugins-hash
typeset -gA Plugins
Plugins[ZCA_DIR]="${0:h}"

CONFIG_DIR="$HOME/.config/zca"

#
# Update FPATH if:
# 1. Not loading with Zi
# 2. Not having fpath already updated (that would equal: using other plugin manager)
#

# https://wiki.zshell.dev/community/zsh_plugin_standard#functions-directory
if [[ $PMSPEC != *f* ]]; then
  fpath+=( "${0:h}/functions" )
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
    command cp "$Plugins[ZCA_DIR]/.config/zca/$__ZCA_CONFIG_FILE" "$CONFIG_DIR"
  fi
done
unset __ZCA_CONFIG_FILE

#
# Load functions
#

autoload h-list zca zca-usetty-wrapper zca-widget
zle -N zca-widget
bindkey '^T' zca-widget
