# search the zsh history for a command fcmd = find command
# Usage; fcm "grep -i 'some search
function fcmd {
	cat ~/.zsh_history | grep $1
}

#function diskutil() 
#	case $1 in
#		"list") shift
#			command diskutil list -plist | plutil -convert json -r -o - -- - | jq -r
#			;;
#	esac
#}
#
#

#diskutil() {
#	args=("$@")
#	case $1 in
#   "list") shift
#     command diskutil list -plist | plutil -convert json -r -o - -- - | jq -r
#     ;;
#	 *)
#		 diskutil "${args[@]}"
#		;;
#
