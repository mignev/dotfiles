source ~/.bash/aliases
source ~/.bash/paths
source ~/.bash/config
source ~/.bash/env

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

if [ -f ~/.localrc ]; then
  . ~/.localrc
fi
