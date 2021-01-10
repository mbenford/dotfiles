# editor
export EDITOR=vim

# path
path+=$HOME/bin
path+=$HOME/.local/bin
typeset -U path

# cdpath
cdpath=(. $HOME)

# tmux
ZSH_TMUX_AUTOSTART=true

# zsh-autosuggest plugin
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# fzf
export FZF_DEFAULT_OPTS='--no-info --height=30%'

# golang
export GOPATH=$HOME/dev/go
path+=$GOPATH/bin
