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

# asdf
if [[ $("which" asdf) ]]; then
    echo "\nasdf is already installed."
else
    echo "\nInstalling asdf..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
    source ~/.zshrc

    # Node.js
    echo "\nInstalling Node.js..."
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs latest
    asdf global nodejs latest
fi

# Rust
if [[ $("which" rustc) ]]; then
    echo "\nRust is already installed in $("which" rustc)."
else
    echo "\nInstalling Rust..."
    yes | curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "\nSuccess."
