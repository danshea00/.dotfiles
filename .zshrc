# nix configuration
if [[ $- == *i* ]]; then  # check if interactive shell
  if [ -x "$HOME/bin/nix-enter" ]; then
    if [ ! -e /nix/var/nix/profiles ] || [ -z ${NIX_ENTER} ]; then
      export NIX_ENTER="TRUE"
      exec "$HOME/bin/nix-enter"
    fi
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/dansh/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions) 

alias vim="nvim"

export VISUAL=vi
export EDITOR="$VISUAL"

source $ZSH/oh-my-zsh.sh

d=~/.dircolors
test -r $d && eval "$(dircolors $d)"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias ls="lsd"

source <(fzf --zsh)
source <(zoxide init zsh)

export GOOGLE_CLOUD_PROJECT=anetorg-sinaraya-kartik

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"

# Rename tmux pane/window when shelling into a4c containers
a4c() {
  if [[ "$1" == "shell" && -n "$2" && "$2" != -* && -n "$TMUX" ]]; then
    local nickname="$2"
    local prev_name
    prev_name=$(tmux display-message -p '#W')
    tmux rename-window "$nickname"
    tmux select-pane -T "$nickname"
    command a4c "$@"
    tmux rename-window "$prev_name"
    tmux select-pane -T ""
  else
    command a4c "$@"
  fi
}
