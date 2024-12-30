# Manual Installation Guide

### Homebrew

Install [Homebrew](https://brew.sh/). Then install the command line utilities, fonts, and GUI macOS apps listed in `.Brewfile`.

```sh
$ brew bundle --file=~/dotfiles/.Brewfile
```

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

Install Go tools.

```sh
$ go install golang.org/x/tools/cmd/goimports@latest
```

Install the JDK

```sh
$ mise use -g java@22
```

Install [Rust](https://www.rust-lang.org/tools/install).

```sh
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
