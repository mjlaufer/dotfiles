# dotfiles

## Prerequisites

This repository is intended for use with macOS. It assumes that you have installed the following:

- [Homebrew](https://brew.sh/)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [GNU stow](http://www.gnu.org/software/stow/) (if you do not use `./homebrew/.Brewfile`)

## Getting Started

Clone this repository into your `$HOME` directory.

```
$ git clone https://github.com/mjlaufer/dotfiles.git
```

Install the command line utilities, fonts, and GUI macOS apps listed in `./homebrew/.Brewfile`.

```
$ brew bundle --file=~/dotfiles/homebrew/.Brewfile
```

Now GNU stow should be installed. Run `stow` in simulation mode to see warnings about possible errors.

Stow throws an error if the symlink destination already exists. Delete these existing files (or change their names) before stowing your custom versions.
```
$ cd ~/dotfiles
$ stow -n PACKAGE_NAME
```

If there are no warnings, you may use `stow` to symlink your dotfiles. Start by installing the Zsh theme and plugins.

```
$ git submodule update --recursive --init
$ stow zsh
```

Then stow the remaining packages.

```
$ stow PACKAGE_NAME
```

Start `yabai` and `skhd`.

```
$ brew services start yabai
$ brew services start skhd
```

## Manual Setup

### Neovim Plugins

- Install [vim-plug](https://github.com/junegunn/vim-plug).
- Open Neovim and run `:PlugInstall`.

### iTerm2 Preferences

Open iTerm2 and navigate to Preferences -> General -> Preferences. Check "Load preferences from a custom folder or URL". Then click "Browse", and find `dotfiles`.
### Install limelight

```
cd ~
git clone https://github.com/koekeishiya/limelight.git
cd limelight
make
ln -s ~/limelight/bin/limelight /usr/local/bin/limelight
```

Update macOS System Preferences > Mission Control:
- Disable "Automatically rearrange Spaces based on most recent use".
- Enable "Displays have separate Spaces".

### Install the `code` command

Open the Command Palette (⇧ + ⌘ + p) and find the "Shell Command: Install 'code' command in PATH" command.

After executing the command, restart the terminal for the new $PATH value to take effect. You can now simply type "code ." in any folder to open VSCode and start editing files in that folder.

### Add VSCode extensions

- [Debugger for Firefox](https://marketplace.visualstudio.com/items?itemName=firefox-devtools.vscode-firefox-debug)
- [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [Version Lens](https://marketplace.visualstudio.com/items?itemName=pflannery.vscode-versionlens)
- [Image Preview](https://marketplace.visualstudio.com/items?itemName=kisstkondoros.vscode-gutter-preview)
- [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
- [npm](https://marketplace.visualstudio.com/items?itemName=eg2.vscode-npm-script&ssr=false#review-details)
- [npm Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.npm-intellisense)
- [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense)
- [DotENV](https://marketplace.visualstudio.com/items?itemName=mikestead.dotenv)
- [Highlight Matching Tag](https://marketplace.visualstudio.com/items?itemName=vincaslt.highlight-matching-tag)
- [Quokka](https://marketplace.visualstudio.com/items?itemName=WallabyJs.quokka-vscode)
- [Themes](https://marketplace.visualstudio.com/items?itemName=mjlaufer.vscode-themes)
- [Thunder Client](https://marketplace.visualstudio.com/items?itemName=rangav.vscode-thunder-client)

### Install [Node Version Manager](https://github.com/nvm-sh/nvm) and Node.js

```
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
$ nvm install node
```

### Add Chrome extensions

- [JSON Formatter](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa?hl=en)
- [Web Vitals](https://chrome.google.com/webstore/detail/web-vitals/ahfhijdlegdabablpippeagghigmibma?hl=en)
- [axe - Web Accessibility Testing](https://chrome.google.com/webstore/detail/axe-web-accessibility-tes/lhdoppojpmngadmnindnejefpokejbdd?hl=en-US)
- [Requestly](https://chrome.google.com/webstore/detail/requestly-redirect-url-mo/mdnleldcmiljblolnjhpnblkcekpdkpa?hl=en)
- [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en)
- [Redux DevTools](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd)

### Add Firefox add-ons

- [axe - Web Accessibility Testing](https://addons.mozilla.org/en-US/firefox/addon/axe-devtools/)
- [React Developer Tools](https://addons.mozilla.org/en-US/firefox/addon/react-devtools/)
- [Redux DevTools](https://addons.mozilla.org/en-US/firefox/addon/reduxdevtools/)
