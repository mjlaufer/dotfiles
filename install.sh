#!/usr/bin/env zsh

echo '\nSetting up dev environment...\n'

# Homebrew
if ! command -v brew &>/dev/null; then
    echo "\nInstalling Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle --file=~/dotfiles/.Brewfile

# Oh My Zsh
if [ -d ~/.oh-my-zsh ]; then
	echo "\nOh My Zsh is already installed."
else
    echo "\nInstalling Oh My Zsh..."
    curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | zsh -s -- --unattended
    cp .zshrc .zshrc.oh-my-zsh-default
fi

cd ~/dotfiles

# Git submodules (Zsh and tmux plugins)
git submodule update --init --recursive

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
mise use -g node@lts

# JDK
echo "\nInstalling OpenJDK..."
mise use -g java@22

# Rust
if ! command -v rustup &>/dev/null; then
    echo "\nInstalling Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

echo "\nSuccess."
