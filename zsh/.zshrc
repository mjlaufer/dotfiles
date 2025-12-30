# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes.
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration
export CLANGBIN="$(brew --prefix)/opt/llvm/bin"
export GOPATH=$HOME/go
export PATH=$HOME/.local/bin:$CLANGBIN:$GOPATH/bin:$PATH

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

# fzf config with Inklight colors
export FZF_DEFAULT_OPTS=" \
  --color=fg:#1b1b1b,bg:#f2f2f2,hl:#007f4e \
  --color=fg+:#1b1b1b,bg+:#e5e5e5,hl+:#007f4e \
  --color=info:#555555,prompt:#1b1b1b,pointer:#c35c88 \
  --color=marker:#c35c88,spinner:#bb0055,header:#555555 \
  --color=border:#d7d7d7,gutter:#e5e5e5 \
  --border=rounded \
  --prompt='❯ ' \
  --pointer='▶'"
source <(fzf --zsh)

source ~/dotfiles/zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up mise for runtime management.
eval "$($(brew --prefix)/bin/mise activate zsh)"

# Set up direnv for env management.
eval "$(direnv hook zsh)"
