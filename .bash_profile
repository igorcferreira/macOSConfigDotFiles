export ANDROID_HOME="$HOME/Library/Android/sdk"
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:/usr/local/freeswitch/bin"
export PATH="$PATH:$HOME/Documents/git/libs/depot_tools"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

export XCODE_CONTENT="/Applications/Xcode.app/Contents"
export DEVELOPER_DIR="$XCODE_CONTENT/Developer"
export JAVA_HOME=`/usr/libexec/java_home`

alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias symbolicatecrash="$XCODE_CONTENT/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"

if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load simple profile
[[ -s "$HOME/.bash_functions" ]] && source "$HOME/.bash_functions" # Loads a set of functions that can be useful

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export GPG_TTY=$(tty)

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
