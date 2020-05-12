# editor
export EDITOR=vim

# path
typeset -U path

# tmux
ZSH_TMUX_AUTOSTART=true

# zsh-autosuggest plugin
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# golang
export GOPATH=$HOME/dev/go
path+=$GOPATH/bin
