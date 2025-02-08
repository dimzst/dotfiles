HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# Export
export LANG=en_US.UTF-8
export LC_COLLATE=C
export TERM_THEME=dark
export EDITOR=nvim
export KEYTIMEOUT=1
export DOOMDIR=~/.config/doom
export GOPATH=$HOME/go
export GOPRIVATE=git.garena.com/shopee,git.garena.com/shopee-server,git.garena.com
export GOPROXY="https://proxy.golang.org,direct"
export FD_OPTIONS="--follow --exclude .git --exclude node_modules --exclude vendor"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='--border --info=inline'
export XPLR_BOOKMARK_FILE="$HOME/xplr_bookmarks"
# End export

# Bindkey
# Fix backspace issue
bindkey "^?" backward-delete-char
bindkey "^U" backward-kill-line
bindkey "^X\x7f" backward-kill-line
bindkey "^X^_" redo
# end bindkey

# Init plugin
if type sheldon > /dev/null; then
    eval "$(sheldon source)"
fi

if type atuin > /dev/null; then
    eval "$(atuin init zsh --disable-up-arrow)"
fi

if type zoxide > /dev/null; then
    eval "$(zoxide init zsh)"
fi
# End init plugin

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Plugin config

# p10k
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# End p10k

# FZF
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# End FZF

# zvm fix
zvm_after_init_commands+=("bindkey -M viins '^R' _atuin_search_widget")
zvm_after_init_commands+=("bindkey -M vicmd '^R' _atuin_search_widget")
# end of zvm fix

# End plugin config


# Alias
alias gf="git fuzzy"
alias ls="exa"
alias ll="exa -l"
alias cht="cht.sh"
alias t="todo.sh"
alias nv="nvim"
alias lg="lazygit"
alias pip2="python2 -m pip"
alias pip3="python3 -m pip"
alias venv2="virtualenv -p python2"
alias venv3="virtualenv -p python3"
# End alias

# Path
export PATH=$PATH:$GOPATH/bin:$HOME/.scripts/shell:$HOME/Repo/git-fuzzy/bin:/usr/local/opt/libpq/bin:$HOME/bin:$HOME/.emacs.d/bin
export PATH="$PATH:/opt/homebrew/opt/libpq/bin"
# End of path

# source $HOME/.venvs/virtenv2/bin/activate
# source $HOME/.venvs/venv/bin/activate

# completion
autoload -U compinit; compinit
