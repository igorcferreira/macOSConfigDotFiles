# These variables are configured for a default M1 mac. If these need to be overwritten on your machine, create a `~/.local.env` file with the values to be overwritten
BREW_PATH="/opt/homebrew"
BREW_BIN_PATH="${BREW_PATH}/bin"

[[ -s "$HOME/.local.env" ]] && source "$HOME/.local.env"

# ssh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# Java configuration
export JAVA_HOME="$(/usr/libexec/java_home -v21)"

# Local scripts
[[ -d "$HOME/Developer/bin" ]] && export PATH="$PATH:$HOME/Developer/bin" # Loads local scripts to be used on Bash
[[ -s "$HOME/.bash_profile" ]] && source "$HOME/.bash_profile" # Loads old bash_profile if exists, to ensure outdated scripts works fine
[[ -s "$HOME/.bash_functions" ]] && source "$HOME/.bash_functions" # Loads a set of functions that can be useful

# SPM executables
[[ -d "$HOME/.swiftpm/bin" ]] && export PATH="$PATH:$HOME/.swiftpm/bin"

# Android configuration
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/build-tools/$(ls -1 $ANDROID_HOME/build-tools | sort -r | head -n 1)"

# Go configuration
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"
export GOROOT="${BREW_PATH}/opt/go/libexec"
export PATH="$PATH:$GOBIN"

# Xcode configuration
#export XCODE_CONTENT="/Applications/Xcode.app/Contents"
#export DEVELOPER_DIR="$XCODE_CONTENT/Developer"
#alias symbolicatecrash="$XCODE_CONTENT/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"

# Airport
alias airport="sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport"

# Ruby configuration
export RUBY_CFLAGS="-Wno-error=implicit-function-declaration"

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Rbenv configuration
[ -s "${BREW_BIN_PATH}/rbenv" ] && eval "$($BREW_BIN_PATH/rbenv init - zsh)"

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
eval "$($BREW_BIN_PATH/brew shellenv)"

# Swift env
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

# GPG
export GPG_TTY=$(tty)

# Mono
export MONO_GAC_PREFIX="${BREW_PATH}"

# Python
alias python="python3"
alias pip="pip3"

# Openssl
export PATH="${BREW_PATH}/opt/openssl@1.1/bin:$PATH"

# Direnv
eval "$(direnv hook zsh)"

# Language set
export LC_ALL=en_US.UTF-8

#Android Studio
export PATH="/Applications/Android Studio.app/Contents/MacOS:$PATH"
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"

# Azure CLI autocomplete
autoload bashcompinit && bashcompinit
[[ -s "$(brew --prefix)/etc/bash_completion.d/az" ]] && source "$(brew --prefix)/etc/bash_completion.d/az"

# SPM
export PATH="$PATH:$HOME/.swiftpm/bin"

# [[ -d "${BREW_PATH}/opt/libffi" ]] && export LDFLAGS="-L$(brew --prefix libffi)/lib"
# [[ -d "${BREW_PATH}/opt/libffi" ]] && export CPPFLAGS="-I$(brew --prefix libffi)/include"
# [[ -d "${BREW_PATH}/opt/libffi" ]] && export PKG_CONFIG_PATH="$(brew --prefix libffi)/lib/pkgconfig"

# NPM
export PATH="$PATH:$(npm get prefix)/bin"

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -d "$HOME/.rvm/bin" ]] && export PATH="$HOME/.rvm/bin:$PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
