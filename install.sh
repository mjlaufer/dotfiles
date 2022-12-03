#!/usr/bin/env sh

echo '\nSetting up dev environment...\n'

# Oh My Zsh
if [ -d ~/.oh-my-zsh ]; then
	echo "Oh My Zsh is already installed.\n"
else
    echo "Installing Oh My Zsh...\n"
    curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
fi

cd ~/dotfiles

# Zsh plugins
git submodule update --init --recursive

# Homebrew
brew bundle --file=~/dotfiles/.Brewfile

# GNU Stow for dotfiles
for source in ~/dotfiles/*; do
    if [ -d "$source" ]; then
        base="$(basename $source)"
        echo "Stowing $base..."
        stow -D $base
        stow $base
    fi
done

# Kitty
echo "\nInstalling/updating Kitty..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Node.js
echo "\nInstalling/updating Node Version Manager and Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
nvm install node

# Rust
if [[ $("which" rustc) ]]; then
    echo "\nRust is already installed in $("which" rustc)."
else
    echo "\nInstalling Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Lua development dependencies
if [[ $("which" lua-format) ]]; then
    echo "\nLua Formatter is already installed in $("which" lua-format)."
else
    echo "\nInstalling Lua Formatter..."
    luarocks install --server=https://luarocks.org/dev luaformatter
fi

echo "\nSuccess."
