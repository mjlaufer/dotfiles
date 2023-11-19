# Amazon Linux 2 Setup Guide

This guide is for setting up a development environment on an Amazon EC2 instance running Amazon Linux 2 (AL2).

## Prerequisites

This repository is intended for use with AL2 and assumes your default shell is zsh.

1. Verify your Linux distribution.

```sh
$ cat /etc/os-release
```

2. Verify that your current shell is Zsh.

```sh
$ echo $0
```

## Installation

### Package managers

This guide generally prefers Linux package managers and installation instructions, but will fall back to Homebrew when alternative installation methods are inconvenient.

Install [EPEL](https://docs.fedoraproject.org/en-US/epel/). The yum package manager, which comes with AL2, does not contain GNU Stow (among other things), but EPEL (Extra Packages for Enterprise Linux) does.

```sh
$ sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

Install [Homebrew](https://brew.sh/). Then follow the instructions in the output to add `brew` to your `PATH`.

### Development Tools and Stow

Check whether the "Development Tools" group (e.g., gcc, make, automake) is installed.

```sh
$ sudo yum groupinfo -v "Development Tools"
```

Install the Development Tools group if it isn't already installed.

```sh
$ sudo yum groupinstall "Development Tools"
```

Install GNU Stow.

```sh
$ sudo yum -y install stow
```

### Clone dotfiles

Clone this repository into your `$HOME` directory.

```sh
$ git clone https://github.com/mjlaufer/dotfiles.git ~/dotfiles
```

Install plugins for Zsh and tmux.

```sh
$ cd ~/dotfiles
$ git submodule update --recursive --init
```

### Zsh

Install [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh). It will automatically rename the current `.zshrc` file to `.zshrc.pre-oh-my-zsh`. Rename (or delete) the `.zshrc` created by Oh My Zsh so you can `stow` this repo's `/zsh` directory without conflicts.

```sh
$ cd ~
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ cp .zshrc .zshrc.oh-my-zsh-default
$ cd dotfiles
$ stow zsh
```

Prepend the contents of `.zshrc.pre-oh-my-zsh` to `.zshrc`.

### tmux

```sh
$ cd ~/dotfiles
$ stow bin
$ stow tmux
```

In AL2, you may need to build tmux from source.

Install tmux dependencies.

```sh
$ sudo yum -y install ncurses-devel
```

Create a directory to store the tmux source and build.

```sh
$ mkdir -p ~/tmux-src
$ cd ~/tmux-src
```

Install libevent because the version that comes with AL2 is too old.

```sh
$ curl -LOk https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/libevent-2.1.11-stable.tar.gz
$ tar xvzf libevent-2.1.11-stable.tar.gz
$ cd libevent-2.1.11-stable
$ ./configure
$ make
$ sudo make install
```

Install tmux.

```sh
$ cd ~/tmux-src
$ curl -LOk https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
$ tar xvzf tmux-3.3a.tar.gz
$ cd tmux-3.3a
$ LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure
$ make
$ sudo make install
```

tmux is now located at usr/local/bin/tmux. You may need to restart your shell.

Install tmux plugins: `<prefix> I`

Install fzf, which is a dependency of `tmux-sessionizer`.

```sh
$ brew install fzf
```

### htop

```sh
$ cd ~/dotfiles
$ stow htop
$ sudo yum -y install htop
```

### lazygit

```sh
$ cd ~/dotfiles
$ stow lazygit
$ brew install lazygit
```

### Neovim

The Neovim config in this repo depends on Node.js for installing LSP servers and DAP debuggers. It also depends on ripgrep for its Telescope plugin.

Install [asdf](https://asdf-vm.com/) and Node.js.

```sh
$ git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
$ source ~/.zshrc
$ asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
$ asdf install nodejs lts
$ asdf global nodejs lts
```

Install ripgrep.

```sh
$ brew install ripgrep
```

Install the Neovim AppImage. Follow the instructions in the [Neovim installation wiki](https://github.com/neovim/neovim/wiki/Installing-Neovim#appimage-universal-linux-package).

```sh
$ cd ~/dotfiles
$ stow nvim
```
