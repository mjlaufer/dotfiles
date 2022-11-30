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

Install [Rust](https://www.rust-lang.org/tools/install)

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Install Neovim LSP dependencies.

```sh
npm install -g typescript
luarocks install --server=https://luarocks.org/dev luaformatter
```

## Install Neovim DAP servers

Use the [Mason](https://github.com/williamboman/mason.nvim) plugin to install [DAP](https://microsoft.github.io/debug-adapter-protocol/) servers.

#### JavaScript/TypeScript

```sh
:MasonInstall js-debug-adapter
```

To debug in Chrome, make sure to first run Chrome with remote debugging enabled:

```sh
chrome-debug
```

#### Rust

```sh
:MasonInstall codelldb
```

## Install/update tmux plugins

-   Install: `<prefix> I`
-   Update: `<prefix> U`

## Add Chrome extensions

-   [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb?hl=en)
-   [JSON Formatter](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa?hl=en)
-   [axe - Web Accessibility Testing](https://chrome.google.com/webstore/detail/axe-web-accessibility-tes/lhdoppojpmngadmnindnejefpokejbdd?hl=en-US)
-   [Web Vitals](https://chrome.google.com/webstore/detail/web-vitals/ahfhijdlegdabablpippeagghigmibma?hl=en)

## Customize IntelliJ

Install and build [Glint](https://github.com/mjlaufer/glint-intellij). Then select **Install Plugin from Disk**.

Select **File | Manage IDE Settings | Settings Repository** from the main menu. Specify the applicable repository URL (see below), and click **Overwrite Local**.

-   [IDEA](https://github.com/mjlaufer/idea-settings)
-   [Webstorm](https://github.com/mjlaufer/webstorm-settings)

## Customize VS Code

Install the `code` command: Open the Command Palette (⇧ + ⌘ + p) and find the **Shell Command: Install 'code' command in PATH** command. After executing the command, restart the terminal for the new `$PATH` value to take effect. You can now simply type `code .` in any folder to open VSCode and start editing files in that folder.

Install extensions:

-   [Glint](https://github.com/mjlaufer/glint-vscode)
-   [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb)
-   [DotENV](https://marketplace.visualstudio.com/items?itemName=dotenv.dotenv-vscode)
-   [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
-   [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
-   [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
-   [Image Preview](https://marketplace.visualstudio.com/items?itemName=kisstkondoros.vscode-gutter-preview)
-   [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
-   [npm Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.npm-intellisense)
-   [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense)
-   [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
-   [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)
-   [Version Lens](https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens)
-   [VSCode Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim)
