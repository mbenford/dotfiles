export ZSH="$HOME/.oh-my-zsh"

# basic configuration
ZSH_THEME="powerlevel10k/powerlevel10k"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="false"
DISABLE_MAGIC_FUNCTIONS=true
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="false"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# history configuration
HISTSIZE=10000
SAVEHIST=10000
HISTORY_IGNORE="(ls|ll|cd|\.\.|\.\.\.|\.\.\.\.|gc|gst|gau|ga|gco|gup)"
HIST_STAMPS="yyyy-mm-dd"


# plugins
plugins=(
	asdf
	bgnotify
	colored-man-pages
	command-not-found
	common-aliases
	fasd
	fast-syntax-highlighting
	git
	sudo
	tmux
	ubuntu
	zsh-autosuggestions
	zsh-tmux-auto-title
)

# Oh My ZSH
source $ZSH/oh-my-zsh.sh

# custom zsh options
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups
unsetopt share_history

# custom aliases
source $HOME/.zsh_aliases

# custom functions
fpath=($HOME/.zfunc "${fpath[@]}")
autoload -U $fpath[1]/*(.:t)

# fix for tilix
if [[ $TILIX_ID ]]; then
	source /etc/profile.d/vte-2.91.sh
fi

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
