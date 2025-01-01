# dotfiles

## Prerequisites

This repository is intended for use with macOS and assumes your default shell is zsh.

1. Install the Xcode command line developer tools.

```sh
$ xcode-select --install
```

2. Clone this repository into your `$HOME` directory.

```sh
$ git clone https://github.com/mjlaufer/dotfiles.git ~/dotfiles
```

## Installation

Run the install script.

```sh
$ ~/dotfiles/install.sh
```

Alternatively, you can follow the [manual installation guide](manual-installation.md).

## tmux setup

-   Install plugins: `<prefix> I`
-   Update plugins: `<prefix> U`

## Neovim setup

### Plugins

Run `:Lazy restore` to install/update all plugins to the state in the lockfile. (See [lazy.nvim](https://lazy.folke.io/).)

### Debugging

To debug in Chrome, make sure to first run Chrome with remote debugging enabled:

```sh
$ chrome-debug
```

To enable remote debugging in Java, run your app with the Java Debug Wire Protocol (JDWP):

```sh
$ java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar [path/to/JAR]
```

## IntelliJ

-   Add theme: Install and build [Flashy](https://github.com/mjlaufer/flashy-intellij). Then select **Install Plugin from Disk**.
-   Sync settings: Select **File | Manage IDE Settings | Settings Sync** from the main menu. Click **Enable Settings Sync...**. Ensure all settings checkboxes are checked, and click **Get Settings from Account**.

## VS Code

-   Add theme: Install [Flashy](https://github.com/mjlaufer/flashy-vscode), and follow the steps in the README.
-   Sync settings: Sign in to VS Code. In the **Activity Bar** (left sidebar), click on the **Accounts** icon (bottom-left corner). Then select **Turn on Settings Sync** from the menu. When prompted, sign in with your GitHub account.
-   Install the `code` command: Open the Command Palette (⇧ + ⌘ + p) and find the **Shell Command: Install 'code' command in PATH** command. After executing the command, restart the terminal for the new `$PATH` value to take effect. You can now simply type `code .` in any folder to open VS Code and start editing files in that folder.
