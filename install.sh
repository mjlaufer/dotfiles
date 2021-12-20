#!/usr/bin/env sh

echo '\nSetting up dev environment...\n'

# Oh My Zsh
if [ -d ~/.oh-my-zsh ]; then
	echo "Oh My Zsh is installed.\n"
else
    echo "Installing Oh My Zsh...\n"
    bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

cd ~/dotfiles

# Zsh plugins
git submodule update --init --recursive

# Homebrew
brew bundle --file=~/dotfiles/.Brewfile

# GNU Stow for dotfiles
for source in ~/dotfiles/*; do
    if [ -d "$source" ]; then
        echo "Stowing $source..."
        stow -D $source
        stow $source
    fi
done

# NVM, Node.js, and Neovim LSP dependencies
if [[ $("which" node) ]]; then
    echo "\nNode.js is installed."
else
    echo "\nInstalling Node Version Manager and Node.js..."
    bash -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh)"
    nvm install node

    echo "Installing Neovim LSP dependencies..."
    npm install -g typescript typescript-language-server vscode-langservers-extracted
fi

echo "\nSuccess."
