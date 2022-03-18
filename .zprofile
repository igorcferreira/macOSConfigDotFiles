# These variables are configured for a default M1 mac. If these need to be overwritten on your machine, create a `~/.local.env` file with the values to be overwritten
BREW_PATH="/opt/homebrew"
BREW_BIN_PATH="${BREW_PATH}/bin"

[[ -s "$HOME/.local.env" ]] && source "$HOME/.local.env"

# ssh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# Java configuration
export JAVA_HOME="$(/usr/libexec/java_home -v11)"

# Local scripts
[[ -d "$HOME/Developer/bin" ]] && export PATH="$PATH:$HOME/Developer/bin" # Loads local scripts to be used on Bash
[[ -s "$HOME/.bash_profile" ]] && source "$HOME/.bash_profile" # Loads old bash_profile if exists, to ensure outdated scripts works fine
[[ -s "$HOME/.bash_functions" ]] && source "$HOME/.bash_functions" # Loads a set of functions that can be useful


# Android configuration
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

# Go configuration
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"
export GOROOT="${BREW_PATH}/opt/go/libexec"
export PATH="$PATH:$GOBIN"

# Xcode configuration
export XCODE_CONTENT="/Applications/Xcode.app/Contents"
export DEVELOPER_DIR="$XCODE_CONTENT/Developer"
alias symbolicatecrash="$XCODE_CONTENT/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"

# Ruby configuration
export RUBY_CFLAGS="-Wno-error=implicit-function-declaration"
export GEM_HOME="$HOME/.gem"

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "${BREW_PATH}/opt/nvm/nvm.sh" ] && \. "${BREW_PATH}/opt/nvm/nvm.sh"  # This loads nvm
[ -s "${BREW_PATH}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${BREW_PATH}/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Rbenv configuration
[ -s "${BREW_PATH}/rbenv" ] && eval "$($BREW_BIN_PATH/rbenv init - zsh)"

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
eval "$($BREW_BIN_PATH/brew shellenv)"

# Swift env
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

# GPG
export GPG_TTY=$(tty)