# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set this to suppress the instant prompt warning
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Source prompt theme if available
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Set up PATH
export PATH="$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Set Snowflake token cache path
export SNOWFLAKE_TOKEN_CACHE_DIR="$HOME/.snowsql/tokencache"
mkdir -p "$SNOWFLAKE_TOKEN_CACHE_DIR"
chmod 700 "$SNOWFLAKE_TOKEN_CACHE_DIR"

# dbt alias
alias dbtf="$HOME/.local/bin/dbt"

# Optional alias for pywal
alias wal="$HOME/.venvs/pywal/bin/wal"
alias uvc='uv clean && uv venv && uv sync --all-packages --dev && source .venv/bin/activate'
alias workon_vasa='cd ~/Devlopment/vasa_data_platform/ && source .venv/bin/activate'
alias db_deploy="databricks bundle deploy --target dev --profile DEFAULT"
git_main() {
  git fetch origin --prune || return 1
  local cur; cur="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" || return 1
  local b="backup/${cur}-$(date +%Y%m%d-%H%M%S)"
  git branch "$b" && echo "Backup created: $b"
  git switch -C main origin/main || return 1
  echo "Now on main at origin/main"
  # Uncomment to also wipe untracked files/dirs:
  # git clean -fd
  # Or the nuclear option (also removes ignored files):
  # git clean -fdx
}


run_bundle(){
	databricks bundle run "$1" -t dev -p dev --no-wait
}
export PATH="$HOME/.cargo/bin:$PATH"

# Dracula Color Theme
eval "$(dircolors ~/.dircolors)"
export PATH="$HOME/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
