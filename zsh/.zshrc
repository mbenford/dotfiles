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

setopt extended_history
setopt hist_ignore_space
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups

# plugins
plugins=(
	tmux
	dircycle
	zsh-autosuggestions
	fast-syntax-highlighting
	common-aliases
	asdf
	git
	z
	bgnotify
	web-search
	sudo
	colored-man-pages
	command-not-found
	ubuntu
)

source $ZSH/oh-my-zsh.sh

# custom scripts
source $HOME/.zsh_aliases

# fix for tilix
if [[ $TILIX_ID ]]; then
	source /etc/profile.d/vte-2.91.sh
fi

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
