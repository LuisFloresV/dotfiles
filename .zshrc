# Path to your zsh installation.
export ZSH=$HOME/.zsh

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv time)

POWERLEVEL9K_DIR_BACKGROUND='white'

# User configuration
export ANDROID_HOME="$HOME/Library/Android/sdk/"
export ANDROID="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_NDK"
export PATH="$PATH:$ANDROID:/usr/local/bin:/usr/local/sbin"

source $ZSH/zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
