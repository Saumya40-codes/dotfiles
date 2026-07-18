# =============================================================================
# ~/.zshrc - modern interactive shell config
# =============================================================================
# Only for interactive shells
[[ $- != *i* ]] && return

# -----------------------------------------------------------------------------
# PATH (deduped, user bins first)
# -----------------------------------------------------------------------------
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.local/kitty.app/bin"
  "$HOME/.grok/bin"
  "$HOME/.cargo/bin"
  "$HOME/.rbenv/bin"
  /usr/local/go/bin
  $path
)
# Go bin (avoid slow `go env` on every shell if go missing)
if [[ -d "$HOME/go/bin" ]]; then
  path+=("$HOME/go/bin")
elif command -v go >/dev/null 2>&1; then
  path+=("$(go env GOPATH)/bin")
fi
export PATH

# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="${EDITOR:-nvim}"
export VISUAL="$EDITOR"
export PAGER="${PAGER:-less}"
export LESS="-RFi"
export GPG_TTY="$(tty 2>/dev/null || true)"

# Prefer bat for man pages when available
if command -v bat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
  export BAT_THEME="Catppuccin Mocha"
fi

# fzf defaults (fd + bat preview when available)
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline"
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi
if command -v bat >/dev/null 2>&1; then
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
fi

# -----------------------------------------------------------------------------
# History (large, shared, smart)
# -----------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY          # timestamps
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE         # leading space → not saved
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY               # edit before run from history
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt SHARE_HISTORY

# -----------------------------------------------------------------------------
# Shell options
# -----------------------------------------------------------------------------
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt PATH_DIRS
setopt EXTENDED_GLOB
# Keep correct off by default - it's noisy; enable with: setopt CORRECT
unsetopt CORRECT
unsetopt CORRECT_ALL

# -----------------------------------------------------------------------------
# Completion
# -----------------------------------------------------------------------------
fpath=(
  "$HOME/.zsh/plugins/zsh-completions/src"
  "$HOME/.grok/completions/zsh"
  $fpath
)

autoload -Uz compinit
# Cache completion dump; rebuild weekly or if missing
_comp_dump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ ! -f $_comp_dump || -n $_comp_dump(#qN.mh+168) ]]; then
  compinit -d "$_comp_dump"
else
  compinit -C -d "$_comp_dump"
fi

zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}no matches%f'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

# -----------------------------------------------------------------------------
# Keybindings
# -----------------------------------------------------------------------------
bindkey -e  # emacs-style
# Word navigation (works well in kitty/tmux)
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# History substring search (loaded after plugin below)
# Up/down bound once plugin is sourced

# -----------------------------------------------------------------------------
# Aliases - modern CLI where available, sensible fallbacks
# -----------------------------------------------------------------------------
# ls / eza
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -alF --group-directories-first --icons=auto --git'
  alias la='eza -a --group-directories-first --icons=auto'
  alias lt='eza --tree --level=2 --icons=auto --group-directories-first'
  alias l='eza -F --group-directories-first --icons=auto'
else
  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi

# cat / bat
if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
  alias batp='bat'
fi

# grep color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# git
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate -20'
alias lg='lazygit'

# editors / tools
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias k='kubectl'
alias d='docker'
alias dc='docker compose'
alias tf='terraform'
alias py='python3'
alias ipy='ipython'

# quality of life
alias c='clear'
alias h='history'
alias path='print -l $path'
alias ports='ss -tulpn'
alias myip='curl -s https://ifconfig.me; echo'
alias update_all='sudo apt update && sudo apt upgrade'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# tailscale
alias tup='sudo tailscale up --accept-routes'
alias tdown='sudo tailscale down'

# dust if present
command -v dust >/dev/null 2>&1 && alias du='dust'

# -----------------------------------------------------------------------------
# Tool initializations (order matters)
# -----------------------------------------------------------------------------
# rbenv
if [[ -d "$HOME/.rbenv" ]]; then
  eval "$(rbenv init - zsh 2>/dev/null)"
fi

# fzf keybindings + completion
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi
if [[ -f /usr/share/doc/fzf/examples/completion.zsh ]]; then
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# zoxide (smart cd) - after compinit
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd='z'  # optional: seamless upgrade; use `builtin cd` when needed
fi

# starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# -----------------------------------------------------------------------------
# Plugins (syntax highlighting MUST be last)
# -----------------------------------------------------------------------------
# Autosuggestions
if [[ -f ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# History substring search
if [[ -f ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down
fi

# Syntax highlighting - always last among plugins
if [[ -f ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# -----------------------------------------------------------------------------
# Optional eye candy (skip in non-TTY / SSH / CI for speed)
# Set SHOW_NEOFETCH=1 to force, or 0 to never.
# -----------------------------------------------------------------------------
if [[ -z "${SHOW_NEOFETCH:-}" ]]; then
  # default: only local interactive graphical terminals, not every pane
  SHOW_NEOFETCH=0
fi
if [[ "$SHOW_NEOFETCH" == "1" ]] && command -v neofetch >/dev/null 2>&1; then
  neofetch
fi
