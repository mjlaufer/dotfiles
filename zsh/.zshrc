# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration
export CLANGBIN="/usr/local/opt/llvm/bin"
export GOPATH=$HOME/go
export PATH=$HOME/.local/bin:$CLANGBIN:$GOPATH/bin:$PATH

# Aliases
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

# C-s to run tmux-sessionizer
stty -ixon
bindkey -s ^s "tmux-sessionizer\n"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/dotfiles/zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up rtx for runtime management.
eval "$(/usr/local/bin/rtx activate zsh)"
