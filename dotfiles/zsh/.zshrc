# HOME VARIABLE & FIRST TIME SETUP
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# PLUGINS
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# OH-MY-ZSH SNIPPETS
zinit snippet OMZP::archlinux
zinit snippet OMZP::aliases
zinit snippet OMZP::common-aliases

# LOAD COMPLETIONS
autoload -Uz compinit && compinit

# COMPLETION STYLING
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# HISTORY
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

# KEYBINDS
bindkey -e
bindkey '^[[A' history-search-backward		# UP ARROW: History backward
bindkey '^[[B' history-search-forward		# DOWN ARROW: History forward
bindkey '^[[1;5C' forward-word				# CTRL + RIGHT ARROW: Move 1 word forward	
bindkey '^[[1;5D' backward-word				# CTRL + LEFT ARROW: Move 1 word backward
bindkey '^E' kill-word						# CTRL + E: Delete word after
bindkey '^W' backward-kill-word				# CTRL + W: Delete word before
bindkey '^D' end-of-line					# CTRL + D: End of line
bindkey '^Z' undo							# CTRL + Z
bindkey '^Y' redo							# CTRL + Y
bindkey '^[[3~' delete-char 				# DELETE

# PERSONAL ALIASES
alias ls="eza -1als name"
alias la="ls -lAFh --color"
alias uzsh="exec zsh"
alias zshrc="micro ~/.zshrc"
alias ff="fastfetch"
alias c="clear"
alias chargemode="~/MyScripts/charging-mode.sh"
alias fkeys="sudo input-remapper-control --command start --device \"SONiX Gaming Keyboard\" --preset fkeys"

# SHELL INTEGRATIONS
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
