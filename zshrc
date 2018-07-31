if [ ! -n "$TMUX" ] && [ ! -n "$VSCODE_CLI" ]; then
  cd ~/dev
fi

# aliases
alias ls="ls -G"
alias l=ls
alias s=ls
alias sl=ls
alias ll=ls
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias vim="nvim"
alias vimdiff="nvim -d"
alias stashpull="git stash save && git pull && git stash pop"
alias t="tmux new"

# functions
function chromeusage {
  local PSAUX=`ps aux | grep Chrome | awk '{sum += $4;} END {print sum;}' "$@"`
  local GB=`echo 'scale=2; 16*' $PSAUX '/100' | bc`
  echo $GB GB
}

# settings
export EDITOR=vim

# path
export PATH=$PATH:$HOME/.bin
export PATH=/usr/local/sbin:$PATH

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_dups
setopt share_history
setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space
unsetopt nomatch

# shortcuts
bindkey '^R' history-incremental-search-backward

# disable changing tmux tab names
DISABLE_AUTO_TITLE=true

# colors
autoload -U colors
colors
export TERM=xterm-256color

# plugins
source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle brew
antigen bundle tmux
antigen bundle vi-mode

antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme paddykontschak/Solarizsh solarizsh

antigen apply

# fix `ls` colors messed up by oh-my-zsh
export LSCOLORS=exfxcxdxbxegedabagacad

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
