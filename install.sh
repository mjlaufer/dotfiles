#!/usr/bin/env zsh

echo '\nSetting up dev environment...\n'

# Oh My Zsh
if [ -d ~/.oh-my-zsh ]; then
	echo "Oh My Zsh is already installed.\n"
else
    echo "Installing Oh My Zsh...\n"
    curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    cp .zshrc .zshrc.oh-my-zsh-default
fi

cd ~/dotfiles

# Git submodules (Zsh and tmux plugins)
git submodule update --init --recursive

# Homebrew packages
brew bundle --file=~/dotfiles/.Brewfile

# GNU Stow to symlink dotfiles
for source in ~/dotfiles/*; do
    if [ -d "$source" ]; then
        base="$(basename $source)"
        echo "Stowing $base..."
        stow -D $base
        stow $base
    fi
done

# Update bat binary cache
bat cache --build

# Kitty terminal
echo "\nInstalling/updating Kitty..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Node.js
echo "\nInstalling Node.js..."
rtx use -g node@lts

# JDK
echo "\nInstalling OpenJDK..."
rtx use -g java@20

# Rust
if [[ $("which" rustc) ]]; then
    echo "\nRust is already installed in $("which" rustc)."
else
    echo "\nInstalling Rust..."
    yes | curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "\nSuccess."
