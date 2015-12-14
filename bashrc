source ~/.bash/aliases
source ~/.bash/tmux_apps
source ~/.bash/paths
source ~/.bash/config
source ~/.bash/env

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

if [ -f ~/.localrc ]; then
  . ~/.localrc
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
