# Path to your oh-my-zsh configuration.
ZSH=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.zsh/themes/
ZSH_THEME="columns"

# Comment following line if you don't want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git compete)

source $ZSH/zsh.sh

# User configuration
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"