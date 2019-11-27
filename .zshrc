export ZSH=$HOME/.oh-my-zsh

ZSH_CUSTOM=$HOME
ZSH_THEME=".theme"

source $ZSH/oh-my-zsh.sh

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
alias history='fc -il 1'

plugins=(git)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR='emacs'

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
eval "$(fasd --init auto)"
alias j='fasd_cd -d'
export LESS=-RiS

export GOPATH=$HOME/gocode
export PATH=$PATH:$GOPATH/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
