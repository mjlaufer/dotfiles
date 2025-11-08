# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes.
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration
export PGBIN="$(brew --prefix)/opt/postgresql@18/bin"
export CLANGBIN="$(brew --prefix)/opt/llvm/bin"
export GOPATH=$HOME/go
export GOPRIVATE="hadrian.buf.dev/gen/go,github.com/Hadrian-MTV/*"
export KREWPATH="${KREW_ROOT:-$HOME/.krew}"
export DOCKERPATH=$HOME/.docker
export PATH=/usr/local/go/bin:$HOME/.local/bin:$PGBIN:$CLANGBIN:$GOBIN:$GOPATH/bin:$KREWPATH/bin:$DOCKERPATH/bin:$PATH

# `kitten ssh` configures the remote environment to mirror the local kitty setup.
alias kssh="kitty +kitten ssh"

unalias glo
glo() {
    if [ "$1" != "" ]
    then
        git -c color.ui=always log --oneline --decorate | head -n"$1"
    else
        git log --oneline --decorate
    fi
}

# Vi mode
bindkey -v

# <C-s> to run tmux-sessionizer
stty -ixon
bindkey -s ^s "tmux-sessionizer\n"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

source <(fzf --zsh)

source ~/dotfiles/zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up mise for runtime management.
eval "$($(brew --prefix)/bin/mise activate zsh)"

# Set up direnv for env management.
eval "$(direnv hook zsh)"

# bun completions
[ -s "/Users/matt.laufer/.bun/_bun" ] && source "/Users/matt.laufer/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
