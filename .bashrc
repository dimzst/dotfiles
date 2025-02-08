[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

preexec() {
    tput cuu1; tput el;
    echo -e "\e[38;5;076m>\e[0m $1";
}

# Load homebrew
eval $(/opt/homebrew/bin/brew shellenv)
# eval $(/usr/local/bin/brew shellenv)

# Options
set -o vi

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

# Init plugin

if type oh-my-posh &> /dev/null ; then
    eval "$(oh-my-posh init bash --config ~/.config/omp/themes/mytheme.omp.json)"
fi
# if type starship &> /dev/null ; then
#     eval "$(starship init bash)"
# fi

if type zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# End FZF

if type atuin &> /dev/null; then
    eval "$(atuin init bash --disable-up-arrow)"
fi

if type direnv &> /dev/null; then
    eval "$(direnv hook bash)"
fi

if type navi &> /dev/null; then
    eval "$(navi widget bash)"
fi

# End init plugin


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
pathadd() {
    if [ -n "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="${PATH:+"$PATH:"}$1"
    fi
}
pathadd "$GOPATH/bin:$HOME/.scripts/shell:$HOME/Repo/git-fuzzy/bin:/usr/local/opt/libpq/bin:$HOME/bin:$HOME/.emacs.d/bin"
# export PATH=$PATH:$GOPATH/bin:$HOME/.scripts/shell:$HOME/Repo/git-fuzzy/bin:/usr/local/opt/libpq/bin:$HOME/bin:$HOME/.emacs.d/bin
# export PATH="$PATH:/opt/homebrew/opt/libpq/bin"

source /Users/dimas.tirthadharma/.config/broot/launcher/bash/br
. "$HOME/.cargo/env"

source ~/.local/share/blesh/ble.sh
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach --rcfile ~/.blerc
[[ ${BLE_VERSION-} ]] && ble-attach

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

