export ZSH=$HOME/.oh-my-zsh

ZSH_CUSTOM=$HOME
ZSH_THEME=".theme"

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

plugins=(git)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
source $ZSH/oh-my-zsh.sh
export EDITOR='emacs'

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
eval "$(fasd --init auto)"
alias j='fasd_cd -d'
alias e='f -e emacs'
export LESS=-RiS
function pr
{
    hub browse -- pull/`git what-branch`
}
alias python='python3'
alias grep='grep -i'
alias tags="find . -name '*.py' ! -path '*test*' ! -path './venv/*' -exec etags -a {} \;"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
