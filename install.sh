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

# Kitty
echo "\nInstalling/updating Kitty..."
bash -c "$(curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin)"

# NVM, Node.js, and Neovim LSP dependencies
if [[ $("which" node) ]]; then
    echo "\nNode.js is installed."
else
    echo "\nInstalling Node Version Manager and Node.js..."
    bash -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash)"
    nvm install node

    echo "Installing TypeScript..."
    npm install -g typescript
fi

# Lua development dependencies
if [[ $("which" lua-format) ]]; then
    echo "\nLua Formatter is installed."
else
    echo "\nInstalling Lua Formatter..."
    luarocks install --server=https://luarocks.org/dev luaformatter
fi

echo "\nSuccess."
