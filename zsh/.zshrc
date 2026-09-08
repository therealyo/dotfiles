has() { command -v "$1" >/dev/null 2>&1; }
source_if_exists() { [ -f "$1" ] && source "$1"; }
add_path_front() { [ -d "$1" ] && export PATH="$1:$PATH"; }

case "$(uname -s)" in
  Darwin) OS_TYPE="macos" ;;
  Linux)  OS_TYPE="linux" ;;
  *)      OS_TYPE="other" ;;
esac

if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
  source_if_exists "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi

add_path_front "$HOME/bin"
add_path_front "$HOME/.local/bin"
add_path_front "$HOME/.local/scripts"
add_path_front "/usr/local/bin"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

[ -d "$ZSH" ] && source "$ZSH/oh-my-zsh.sh"

if [ -f "$HOME/.asdf/asdf.sh" ]; then
  source "$HOME/.asdf/asdf.sh"
elif [ -f "/opt/asdf/asdf.sh" ]; then
  source "/opt/asdf/asdf.sh"
elif has brew; then
  source_if_exists "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
fi

export PATH="$HOME/.asdf/shims:$PATH"

export NVM_DIR="$HOME/.nvm"
source_if_exists "$NVM_DIR/nvm.sh"
source_if_exists "$NVM_DIR/bash_completion"

if has brew; then
  source_if_exists "$(brew --prefix)/opt/nvm/nvm.sh"
  source_if_exists "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
fi

source_if_exists "$HOME/.fzf.zsh"
has fzf && source <(fzf --zsh 2>/dev/null) 2>/dev/null

source_if_exists "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_if_exists "$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source_if_exists "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_if_exists "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

if has brew; then
  source_if_exists "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  source_if_exists "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

export EDITOR=nvim
export MANPAGER='nvim +Man!'

if has go; then
  add_path_front "$(go env GOPATH)/bin"
  GOBIN_DIR="$(go env GOBIN 2>/dev/null)"
  [ -n "$GOBIN_DIR" ] && add_path_front "$GOBIN_DIR"
fi

source_if_exists "$HOME/.cargo/env"

export BUN_INSTALL="$HOME/.bun"
add_path_front "$BUN_INSTALL/bin"
source_if_exists "$HOME/.bun/_bun"

source_if_exists "$HOME/.gvm/scripts/gvm"

source_if_exists "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
source_if_exists "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"
source_if_exists "$HOME/google-cloud-sdk/path.zsh.inc"
source_if_exists "$HOME/google-cloud-sdk/completion.zsh.inc"

if has brew; then
  add_path_front "$(brew --prefix)/opt/curl/bin"
  add_path_front "$(brew --prefix)/opt/libpq/bin"
fi

if has eza; then
  alias l='eza -1A --group-directories-first --color=always'
  alias ls='l'
  alias la='l -l --time-style="+%Y-%m-%d %H:%M" --no-permissions --octal-permissions'
  alias tree='l --tree'
fi

alias ga='git add'
alias gap='ga --patch'
alias gb='git branch'
alias gba='gb --all'
alias gc='git commit'
alias gca='gc --amend --no-edit'
alias gce='gc --amend'
alias gco='git checkout'
alias gcl='git clone --recursive'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gds='gd --staged'
alias gi='git init'
alias glog='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias gm='git merge'
alias gn='git checkout -b'
alias gp='git push'
alias gr='git reset'
alias gs='git status --short'
alias k='kubectl'

decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  [ $len -eq 2 ] && result="$1=="
  [ $len -eq 3 ] && result="$1="
  echo "$result" | tr '_-' '/+' | openssl enc -d -base64
}

decode_jwt() {
  decode_base64_url "$(echo -n "$2" | cut -d "." -f "$1")" | jq .
}

alias jwth="decode_jwt 1"
alias jwtp="decode_jwt 2"

export VENV_HOME="$HOME/.virtualenvs"
mkdir -p "$VENV_HOME"

lsvenv() { ls -1 "$VENV_HOME"; }

venv() {
  [ $# -eq 0 ] && echo "Please provide venv name" || source "$VENV_HOME/$1/bin/activate"
}

mkvenv() {
  [ $# -eq 0 ] && echo "Please provide venv name" || python3 -m venv "$VENV_HOME/$1"
}

rmvenv() {
  [ $# -eq 0 ] && echo "Please provide venv name" || rm -r "$VENV_HOME/$1"
}

json() {
  has fx || { echo "fx not installed"; return 1; }

  if [ $# -eq 0 ]; then
    has pbpaste && pbpaste | fx ||
    has xclip && xclip -selection clipboard -o | fx ||
    has wl-paste && wl-paste | fx ||
    has powershell.exe && powershell.exe Get-Clipboard | fx ||
    echo "No clipboard provider"
  else
    echo "$@" | fx
  fi
}

has ngrok && eval "$(ngrok completion)"

bindkey -s ^f ". projects\n"

if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi
if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
  source /usr/share/doc/fzf/examples/completion.zsh
fi

fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

# opencode
export PATH=~/.opencode/bin:$PATH
# wtp
eval "$(wtp hook bash)"
eval "$(wtp shell-init zsh)"

# direnv
eval "$(direnv hook zsh)"

# kubectl autocomplete
source <(kubectl completion zsh)
