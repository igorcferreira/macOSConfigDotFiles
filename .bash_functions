#!/bin/zsh

# Forcefully cleans Derived Data
function kill_dd() {
	killall Xcode
	rm -rf ~/Library/Developer/Xcode/DerivedData
	open -a Xcode
}

function kill_beta_dd() {
	killall Xcode
	rm -rf ~/Library/Developer/Xcode-beta/DerivedData
	open -a Xcode-beta
}

function myip() {
	dig +short myip.opendns.com @resolver1.opendns.com
}

function list_ssh_tunnels() {
	ps -ax | grep 'ssh -L' | grep -v 'grep'
}

function docker_cleanup() {
	kubectl delete po $(kubectl get po --no-headers -n=docker | awk '{print $1}') -n=docker
	kubectl delete po $(kubectl get po --no-headers -n=kube-system | awk '{print $1}') -n=kube-system
	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)
	docker rmi $(docker images -a -q)
	docker network rm $(docker network ls -q)
}

func export_code_plugin_list() {
	OUTPUT_FILE="$1"

	EXPORT_COMMAND="code --list-extensions | xargs -L 1 echo code --install-extension"

	if [[ -f "$OUTPUT_FILE" ]]; then
		rm "$OUTPUT_FILE"
	fi

	sh -c "$EXPORT_COMMAND" > "$OUTPUT_FILE"
}

function rsanewkeypair() {
	openssl genrsa -out privatekey.pem 2048 && \
	openssl rsa -in privatekey.pem -outform PEM -pubout -out publickey.pem
}

function dump_apk_header() {
	BUILD_TOOL="$(ls -tU $ANDROID_HOME/build-tools | head -1)"
	APK_PATH="$1"
	"$ANDROID_HOME/build-tools/$BUILD_TOOL/aapt2" dump badging $APK_PATH
}

function create_bitrise_app() {
	BITRISE_API_TOKEN=""
	BITRISE_ORGANIZATION_ID=""

	while [ -n "$1" ]; do
		case "$1" in
			--api_token | -a) BITRISE_API_TOKEN="$2" && shift ;;
			--organization_id | -o) BITRISE_ORGANIZATION_ID="$2" && shift ;;
		esac
		shift
	done

	bash <(curl -sfL "https://raw.githubusercontent.com/bitrise-io/bitrise-add-new-project/master/_scripts/run.sh") --api-token "$BITRISE_API_TOKEN" --org "$BITRISE_ORGANIZATION_ID" --public "false" --website
}

# Looks for the app of an Application
function path_for_app() {
	NAME_APP=$1
	PATH_LAUNCHSERVICES="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"
	${PATH_LAUNCHSERVICES} -dump | grep -o "/.*${NAME_APP}.app" | grep -v -E "Caches|TimeMachine|Temporary|/Volumes/${NAME_APP}" | uniq
}

function copy_branch_content() {
	FROM=$1
	TO=$2
	BASED=$3

	if [ -z "$BASED" ]; then
		BASED="master"
	fi

	git checkout "$TO"
	git checkout -b "cherry_pick/$FROM/$TO"
	git cherry-pick "$BASED".."$TO"
}

function list_open_ports() {
	netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|"
}

function launch_freeswtich() {
	/usr/local/freeswitch/bin/freeswitch
}

# Nukes all Xcode cache folders
function kill_all() {
	killall Xcode
	rm -rf ~/Library/Developer/Xcode/DerivedData
	rm -rf ~/Library/Developer/Xcode/Archives
	rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport
	rm -rf ~/Library/Caches/com.apple.dt.Xcode
	xcrun simctl delete unavailable
}

# Install a git alias that allow you to list git history by running `git adog`
function install_adog() {
	CONFIGURATION=""
	if [ -z "$1" ]; then
		CONFIGURATION="--local"
	else
		CONFIGURATION="$1"
	fi

	echo "git config $CONFIGURATION alias.adog \"log --all --decorate --oneline --graph\""
	git config "$CONFIGURATION" alias.adog "log --all --decorate --oneline --graph"
}

# This method looks to the latest change in a specific line, and shows the history before that line
function git_log_blame_line() {
	if [ -z "$1" -o -z "$2" ]; then
		echo "Usage: $0 [line] [file]"
	else
		BLAME="$(git blame -L $1,$1 $2)"
		COMMIT="$(echo $BLAME | grep -o '[A-Za-z0-9]\{1,\}' | head -1)"
		git log --decorate --graph "$COMMIT"
	fi
}

# This method iterates the submodules and check if there is any submodule that needs to be pushed
function check_submodule_status() {
	CURRENT_PATH="$PWD"

	if [ ! -f "$CURRENT_PATH/.gitmodules" ]; then
		echo "$CURRENT_PATH/.gitmodules is not a root git folder, or .gitmodules files do not exist."
		return 1
	fi

	for SUBMODULE in $(git config --file "$CURRENT_PATH/.gitmodules" --get-regexp path | cut -d " " -f 2); do
		FULL_PATH="$CURRENT_PATH/$SUBMODULE"
		if [ -d "$FULL_PATH" ]; then
			git_check_status "$FULL_PATH"
		fi
	done
}


# Creates a list of all submodules in the git
function git_list_submodules() {
	CURRENT_PATH="$PWD"
	for SUBMODULE in $(git config --file .gitmodules --get-regexp path | cut -d " " -f 2); do
		FULL_PATH="$CURRENT_PATH/$SUBMODULE"
		if [ -d "$FULL_PATH" ]; then
			echo "$FULL_PATH"
		fi
	done
}

# This updates all the outdated gems in the gemspec
function gem_update_all() {
	for element in $(gem outdated | cut -d ' ' -f 1); do
		echo "Updating ${element}"
		gem update "${element}"
	done
}

# This method checks the status of a git repo, and indicates if there is any change to be pushed
function git_check_status() {

	CLEAR_MESSAGE="working tree clean"

	if [ ! -z "$1" ]; then
		GIT_PATH="$1"
		STATUS_CALL="LANG=en_GB git -C \"$1\" status"
	else
		GIT_PATH="$PWD"
		STATUS_CALL="LANG=en_GB git status"
	fi

	if [ ! -d "$GIT_PATH" ]; then
		echo "$GIT_PATH is not a folder. Usage: $0 [path]"
		return 1
	else
		STATUS_RESULT=$(eval "$STATUS_CALL")
	fi

	if [[ $(eval "echo \"$STATUS_RESULT\" | grep -op \"$CLEAR_MESSAGE\"") == "$CLEAR_MESSAGE" ]]; then
		echo "Path $GIT_PATH is OK"
		return 0
	else
		echo "Path $GIT_PATH is not OK:"
		echo "$STATUS_RESULT"
		return 1
	fi
}

# This method helps to move all branches from one remote to another
function move_repo() {
	if [[ -z "$3" ]]; then
		echo "Missing initial/default branch"
		echo "The current use of the command is:"
		echo "$0 [source remote] [destination remote] [default branch]"
		exit 1
	fi

	if [[ ! -z "$4" ]]; then
		echo "Missing initial/default branch"
		echo "The current use of the command is:"
		echo "$0 [source remote] [destination remote] [default branch]"
		exit 1
	fi

	for branch in $(git branch -r | grep "$1/" | sed "s/$1\///g" | grep -v "HEAD" | grep -v "$3"); do
		eval "git checkout $branch $1/$branch && git push $2 $branch && git checkout $3 && git branch -D $branch"
	done
}

function switch_java_8() {
	export JAVA_HOME="$(/usr/libexec/java_home -v1.8)"
}

function switch_java_11() {
	export JAVA_HOME="$(/usr/libexec/java_home -v11)"
}

function switch_java_latest() {
	export JAVA_HOME="$(/usr/libexec/java_home)"
}

# This method runs the git clone, and already updates all submodules
function git_clone_submodules() {
	git clone "$@"
	git submodule update --init --recursive
}

# This method fixes the broken call to start an android emulator
function open_avd_emulator() {
	if [ -z "$1" ]; then
		echo "Usage: $0 <Emulator name>"
		echo "You can run 'emulator -list-avds' to check the installed emulators."
		echo "Current emulators available:"
		$ANDROID_HOME/emulator -list-avds
		return 1
	fi

	$ANDROID_HOME/emulator -avd "$1"
}