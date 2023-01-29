#!/usr/bin/env sh
# shellcheck disable=SC2039,SC2154,SC3054

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
	cd ~/.config/zca/zsh-cmd-architect || exit
	git pull origin main
else
	cd ~/.config/zca || exit
	git clone https://github.com/z-shell/zsh-cmd-architect.git zsh-cmd-architect
fi
echo ">>> Done"

#
# Copy configs
#

echo ">>> Copying config files"

cd ~/.config/zca || exit

set h-list.conf zca.conf

for i; do
	if ! test -f "$i"; then
		cp -v zsh-cmd-architect/.config/zca/"$i" .
	fi
done

echo ">>> Done"

#
# Modify .zshrc
#

echo ">>> Updating .zshrc"
if ! grep zsh-cmd-architect ~/.zshrc >/dev/null 2>&1; then
cat << EOF > ~/.zshrc

### ZCA's installer added snippet ###
# trunk-ignore(shfmt/parse)
fpath=( "${fpath[@]}" "${HOME}/.config/zca/zsh-cmd-architect" )
autoload h-list zca zca-usetty-wrapper zca-widget
zle -N zca-widget
bindkey '^T' zca-widget
### END ###

EOF

else
	echo ">>> .zshrc already updated, not making changes"
fi
