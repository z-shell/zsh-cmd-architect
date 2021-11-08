#!/bin/sh

if ! type git 2>/dev/null 1>&2; then
    echo "Please install GIT first"
    echo "Exiting"
    exit 1
fi

#
# Clone or pull
#

if ! test -d "$HOME/.config"; then
    mkdir "$HOME/.config"
fi

if ! test -d "$HOME/.config/zca"; then
    mkdir "$HOME/.config/zca"
fi

echo ">>> Downloading zsh-cmd-architect to ~/.config/zca"
if test -d ~/.config/zca/zsh-cmd-architect; then
    cd ~/.config/zca/zsh-cmd-architect
    git pull origin master
else
    cd ~/.config/zca
    git clone https://github.com/z-shell/zsh-cmd-architect.git zsh-cmd-architect
fi
echo ">>> Done"

#
# Copy configs
#

echo ">>> Copying config files"

cd ~/.config/zca

set h-list.conf zca.conf

for i; do
    if ! test -f "$i"; then
        cp -v zsh-cmd-architect/.config/zca/$i .
    fi
done

echo ">>> Done"

#
# Modify .zshrc
#

echo ">>> Updating .zshrc"
if ! grep zsh-cmd-architect ~/.zshrc >/dev/null 2>&1; then
    echo >>~/.zshrc
    echo "### ZCA's installer added snippet ###" >>~/.zshrc
    echo "fpath=( \"\$fpath[@]\" \"\$HOME/.config/zca/zsh-cmd-architect\" )" >>~/.zshrc
    echo "autoload h-list zca zca-usetty-wrapper zca-widget" >>~/.zshrc
    echo "zle -N zca-widget" >>~/.zshrc
    echo "bindkey '^T' zca-widget" >>~/.zshrc
    echo "### END ###" >>~/.zshrc
    echo ">>> Done"
else
    echo ">>> .zshrc already updated, not making changes"
fi
