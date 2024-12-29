# dotfiles

## Prerequisites

This repository is intended for use with macOS and assumes your default shell is zsh.

1. Install the Xcode command line developer tools.

```sh
$ xcode-select --install
```

2. Install [Homebrew](https://brew.sh/).

3. Clone this repository into your `$HOME` directory.

```sh
$ git clone https://github.com/mjlaufer/dotfiles.git ~/dotfiles
```

## Installation

Run the install script.

```sh
$ ~/dotfiles/install.sh
```

## Manual installation

### Oh My Zsh

Install [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh). It will automatically rename the current `.zshrc` file (if one exists) to `.zshrc.pre-oh-my-zsh`. Rename (or delete) the `.zshrc` created by Oh My Zsh so you can `stow` this repo's `zsh/` contents without conflicts.

```sh
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ cp .zshrc .zshrc.oh-my-zsh-default
```

### Git submodules (Zsh and tmux plugins)

Install plugins for Zsh and tmux.

```sh
$ cd ~/dotfiles
$ git submodule update --recursive --init
```

To update plugins, run the following:

```sh
$ git submodule update --remote
```

### Homebrew packages

Install the command line utilities, fonts, and GUI macOS apps listed in `.Brewfile`.

```sh
$ brew bundle --file=~/dotfiles/.Brewfile
```

### `Stow` (symlink) dotfiles

Now GNU Stow should be installed. Run `stow` in simulation mode to see warnings about possible errors.

Stow throws an error if the symlink destination already exists. Delete these existing files (or change their names) before stowing your custom versions.

```sh
$ stow -n PACKAGE_NAME
```

If there are no warnings, you may use `stow` to symlink your dotfiles.

```sh
$ stow PACKAGE_NAME
```

To install the [bat](https://github.com/sharkdp/bat/#adding-new-themes) theme used by [lazygit](https://github.com/jesseduffield/lazygit)/[delta](https://github.com/dandavison/delta), update the bat binary cache:

```sh
$ bat cache --build
```

### Kitty terminal

Install [Kitty](https://sw.kovidgoyal.net/kitty).

```sh
$ curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

### Programming languages

Install Node.js.

```sh
$ mise use -g node@lts
```

Install the JDK

```sh
$ mise use -g java@20
```

Install [Rust](https://www.rust-lang.org/tools/install).

```sh
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## tmux setup

-   Install plugins: `<prefix> I`
-   Update plugins: `<prefix> U`

## Neovim setup

### Plugins

Run `:Lazy restore` to install/update all plugins to the state in the lockfile. (See [lazy.nvim](https://lazy.folke.io/).)

### DAP servers

Use `:MasonInstall [SERVER_NAME]` (see [Mason](https://github.com/williamboman/mason.nvim)) to install [DAP](https://microsoft.github.io/debug-adapter-protocol/) servers:

-   C/Rust: `codelldb`
-   Go: `delve`
-   Java: `java-debug-adapter` and `java-test`
-   JavaScript/TypeScript: `js-debug-adapter`

To debug in Chrome, make sure to first run Chrome with remote debugging enabled:

```sh
$ chrome-debug
```

To enable remote debugging in Java, run your app with the Java Debug Wire Protocol (JDWP):

```sh
$ java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar [path/to/JAR]
```

## Chrome extensions

-   [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb?hl=en)
-   [JSON Formatter](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa?hl=en)
-   [axe - Web Accessibility Testing](https://chrome.google.com/webstore/detail/axe-web-accessibility-tes/lhdoppojpmngadmnindnejefpokejbdd?hl=en-US)
-   [Web Vitals](https://chrome.google.com/webstore/detail/web-vitals/ahfhijdlegdabablpippeagghigmibma?hl=en)

## Firefox extensions

-   [Vimium-FF](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff)

## IntelliJ

Install and build [Flashy](https://github.com/mjlaufer/flashy-intellij). Then select **Install Plugin from Disk**.

Select **File | Manage IDE Settings | Settings Sync** from the main menu. Click **Enable Settings Sync...**. Ensure all settings checkboxes are checked, and click **Get Settings from Account**.

## VS Code

Install the `code` command: Open the Command Palette (⇧ + ⌘ + p) and find the **Shell Command: Install 'code' command in PATH** command. After executing the command, restart the terminal for the new `$PATH` value to take effect. You can now simply type `code .` in any folder to open VS Code and start editing files in that folder.

Install extensions:

-   [Flashy](https://github.com/mjlaufer/flashy-vscode)
-   [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
-   [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
-   [Image Preview](https://marketplace.visualstudio.com/items?itemName=kisstkondoros.vscode-gutter-preview)
-   [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
-   [Version Lens](https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens)
-   [VSCodeVim](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim)
