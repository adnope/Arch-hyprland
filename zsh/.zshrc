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
bindkey '^k' history-search-backward
bindkey '^n' history-search-forward

# PERSONAL ALIASES
alias ls="ls --color"
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
