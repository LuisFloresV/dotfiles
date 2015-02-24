# Path to your zsh configuration.
ZSH=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.zsh/themes/
ZSH_THEME="columns"

# Comment following line if you don't want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git contest)

source $ZSH/zsh.sh

# User configuration
export ANDROID_HOME="/Users/luisfcofv/Library/Android/sdk/"
export ANDROID_NDK="/Users/luisfcofv/Library/Android/android-ndk-r10d/"
export ANDROID="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_NDK"
export PATH="$PATH:$ANDROID:/usr/local/bin:/usr/local/sbin"
