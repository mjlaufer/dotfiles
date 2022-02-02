# dotfiles

## Prerequisites

This repository is intended for use with macOS.

1. Install [Homebrew](https://brew.sh/).

2. Clone this repository into your `$HOME` directory.

```sh
git clone https://github.com/mjlaufer/dotfiles.git ~/dotfiles
```

## Installation

Run the install script.

```sh
~/dotfiles/install.sh
```

## Manual installation

Install Zsh plugins.

```sh
cd ~/dotfiles
git submodule update --recursive --init
```

Install the command line utilities, fonts, and GUI macOS apps listed in `.Brewfile`.

```sh
brew bundle --file=~/dotfiles/.Brewfile
```

Now GNU Stow should be installed. Run `stow` in simulation mode to see warnings about possible errors.

Stow throws an error if the symlink destination already exists. Delete these existing files (or change their names) before stowing your custom versions.

```sh
stow -n PACKAGE_NAME
```

If there are no warnings, you may use `stow` to symlink your dotfiles.

```sh
stow PACKAGE_NAME
```

Install [Kitty](https://sw.kovidgoyal.net/kitty).

```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

Install [Node Version Manager](https://github.com/nvm-sh/nvm) and Node.js.

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node
```

Install Neovim LSP dependencies.

```sh
npm install -g typescript
luarocks install --server=https://luarocks.org/dev luaformatter
```

## Install/update tmux plugins

-   Install: `<prefix> I`
-   Update: `<prefix> U`

## Start yabai

### Update macOS System Preferences > Mission Control

-   Disable "Automatically rearrange Spaces based on most recent use".
-   Enable "Displays have separate Spaces".

### Install limelight

```sh
cd ~
git clone https://github.com/koekeishiya/limelight.git
cd limelight
make
ln -s ~/limelight/bin/limelight /usr/local/bin/limelight
```

Start yabai and skhd.

```sh
brew services start yabai
brew services start skhd
```

## Add Browser extensions

### Brave

-   [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb?hl=en)
-   [axe - Web Accessibility Testing](https://chrome.google.com/webstore/detail/axe-web-accessibility-tes/lhdoppojpmngadmnindnejefpokejbdd?hl=en-US)
-   [JSON Formatter](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa?hl=en)
-   [Web Vitals](https://chrome.google.com/webstore/detail/web-vitals/ahfhijdlegdabablpippeagghigmibma?hl=en)
-   [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en)

### Firefox

-   [axe - Web Accessibility Testing](https://addons.mozilla.org/en-US/firefox/addon/axe-devtools/)
-   [React Developer Tools](https://addons.mozilla.org/en-US/firefox/addon/react-devtools/)

## Customize VS Code

### Install the `code` command

Open the Command Palette (⇧ + ⌘ + p) and find the "Shell Command: Install 'code' command in PATH" command.

After executing the command, restart the terminal for the new $PATH value to take effect. You can now simply type "code ." in any folder to open VSCode and start editing files in that folder.

### Install extensions

-   [Debugger for Firefox](https://marketplace.visualstudio.com/items?itemName=firefox-devtools.vscode-firefox-debug)
-   [DotENV](https://marketplace.visualstudio.com/items?itemName=mikestead.dotenv)
-   [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
-   [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
-   [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
-   [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
-   [Highlight Matching Tag](https://marketplace.visualstudio.com/items?itemName=vincaslt.highlight-matching-tag)
-   [Image Preview](https://marketplace.visualstudio.com/items?itemName=kisstkondoros.vscode-gutter-preview)
-   [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
-   [npm](https://marketplace.visualstudio.com/items?itemName=eg2.vscode-npm-script&ssr=false#review-details)
-   [npm Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.npm-intellisense)
-   [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense)
-   [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
-   [Quokka](https://marketplace.visualstudio.com/items?itemName=WallabyJs.quokka-vscode)
-   [Themes](https://marketplace.visualstudio.com/items?itemName=mjlaufer.vscode-themes)
-   [Version Lens](https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens)
