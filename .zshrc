# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="~/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

plugins=(git fzf-tab zsh-completions docker docker-compose tmux)
# Would you like to use another custom folder than $ZSH/custom?
#case $__CFBundleIdentifier in
#  com.googlecode.iterm2)
#    TMUX_SESSIONS=$(tmux list-sessions | awk -F':' {'print $1'})
#    if [[ "$TMUX_SESSIONS" == *"TMUX"* ]]; then
#      tmux attach -t TMUX
#    else
#      tmux new -s TMUX
#    fi
#    ;;
#  com.jetbrains.pycharm)
#    true
#    ;;
#esac
# Check which app is currently launching zshrc, and then execute some code.
# Fixes an annoyance where tmux would the exact same session in any terminal window, including Pycharm.
# Now, only do that when running iTerm. The Pycharm case statement does nothing right now,
# but leaving in there for the future if I need/want conditional loading of shell things for the IDE.
#case $__CFBundleIdentifier in
#
#  com.googlecode.iterm2)
#    TMUX_SESSIONS=$(tmux list-sessions | awk -F':' {'print $1'})
#    if [[ "$TMUX_SESSIONS" == *"TMUX"* ]]; then
#      tmux attach -t TMUX
#    else
#      tmux new -s TMUX
#    fi
#    ;;
#  com.jetbrains.pycharm)
#    true
#    ;;
#esac

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export PATH=$HOME/anaconda3/bin:$PATH
export PATH="/usr/local/opt/node@14/bin:$PATH"

# aws aliases
alias awslogpaths="aws logs describe-log-groups | jq '.logGroups[].logGroupName'"
alias awsregion="aws configure set default.region"
alias cpaws="cat ~/.aws/credentials | pbcopy"
alias amzn_al2_ami="aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1 | jq '.Parameters[0].Value'"

# consul aliases
alias cprx="ktl port-forward service/server-server 8501:8501"
alias cent="~/Downloads/consul"
alias ce_server="helm install --wait hashicorp-server hashicorp/consul --version="0.39.0" -f "
alias ce_client="helm install --wait hashicorp-client hashicorp/consul --version="0.39.0" -f "

# gcp aliases
alias gcp_ip="terraform show -json | jq '.values.root_module.resources' | jq '.[].values' | jq '.network_interface[].access_config[].nat_ip'"

#jq aliases
alias jk="jq 'keys'"

# kube aliases
alias ktl="kubectl"
alias pods="ktl get pods"
alias nodes="ktl get nodes"
alias kctoken="ktl get secrets server-bootstrap-acl-token -o json | jq -r '.data.token' | base64 -d | pbcopy"
alias deployments="ktl get deployments"
alias services="ktl get services"
alias kctx="ktl config get-contexts -o name"
alias kswt="ktl config use-context $1"
alias wpods="watch -n2 kubectl get pods"

# shell aliases
alias tc="~/.scripts/tutorial-container.sh"
alias hist="cat ~/.zsh_history | grep "
alias cat="bat"
alias ic="~/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias myip="http checkip.amazonaws.com | cat"
alias iq="instruqt"

# terraform aliases
alias tfbuild="tflint && terraform fmt && terraform validate"
alias tfo="terraform output -json | jq -r"
# tmux aliases
alias tm4='tmux new-session -t startup \; split-window -h \; split-window -v \; select-pane -t 0 \; split-window -v \;'

# Environment
source ~/.consulrc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc # in your profile to enable shell command completion for gcloud.
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc # in your profile to add the Google Cloud SDK command line tools to your $PATH.


# terraform autocompletion
complete -o nospace -C /usr/local/bin/terraform terraform
complete            -C aws_completer aws

autoload -U +X bashcompinit && bashcompinit
autoload -U    compinit     && compinit

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source <(kubectl completion zsh)
alias k=kubectl
compdef __start_kubectl k
#eval $(docker-machine env docker-debian-10)
alias cat=bat

# Vault installation
#
alias vup="vagrant up --provider virtualbox"
alias vdf="vagrant destroy -f"

#function diskutil() {
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
#	esac
#}
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export TIME_STYLE="long-iso"

opon() {
  if [[ -z $OP_SESSION_accountname ]]; then
    eval $(op signin accountname)
  fi
}

opoff() {
  op signout
  unset OP_SESSION_marsdominion
}


# AWS functions
# Usage: ssm-ssh <container> <task_id>
function ssm-ssh { aws ecs execute-command --region us-east-1 --cluster clust1 --task $2 --container $1 --command "/bin/sh" --interactive
}

# Lookup a cloudtrail event by the attribute value. In ECS, this is the Task ID.
function ct() { aws cloudtrail lookup-events --lookup-attributes AttributeKey=Username,AttributeValue=$1 --max-results=10 | jq -r '.Events[].CloudTrailEvent' | jq
}

# Tail a Cloudwatch log path
function awslogstail() {
	aws logs tail $1 --follow
}


# docker functions

# Pull a Docker image from ECR.
function dawker() {
	# dawker pull amazonlinux/amazonlinux:latest
	case $1 in
		"pull") shift
			# docker pull public.ecr.aws/amazonlinux/amazonlinux:latest
			docker pull public.ecr.aws/$1
			;;
	esac
}

# Consul functions
# Query the Consul HTTP API
# Usage:
# capi kv/foo -p "hello world" - post request to endpoint
# capi catalog/services <-No method default to GET
function capi() {
  URL=$CONSUL_HTTP_ADDR
  TOKEN=$CONSUL_HTTP_TOKEN
  BASE_URL="${URL}/v1"
  ENDPOINT=$1
  TOKEN_HEADER="X-Consul-Token:${TOKEN}"
  while getopts ":p" o; do
    case $o in
      p)
        m=$OPTARG
        echo "m is ${OPTARG} or $m"
        ;;
      d)
        data=${OPTARG}
        [ -z $data ] && echo "data was blank"
        ;;
    esac
  done
  # post $p with data $d as non zero length
  if [ $m == "p" ] && [ -n  $data ]; then
    echo "found a put"
    http PUT "${BASE_URL}/${ENDPOINT}" "${TOKEN_HEADER}" $data
  # Set a get, or didn't pass the method? Assume get
  elif [ $m == "g" ] || [ -z $m ] && [ -z $d ]; then
    echo "found a get"
    http "${BASE_URL}/${ENDPOINT}" "${TOKEN_HEADER}"
  else
    echo "Something went wrong!"
  fi
}

# shell functions
function fcm() {
	cat ~/.zsh_history | grep $1
}

# Terraform functions
function tf() {
  case $1 in
    "apply") shift
      terraform apply -auto-approve && say "deploy done"
      ;;
    "destroy") shift
      terraform destroy -auto-approve &&  say "destroy done"
      ;;
  esac
}

# twitter functions
# Get a twitter embed URL by passing a link.
function tembed() {
	http https://publish.twitter.com/oembed\?url\=$1 | jq -r .html
}

#if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
#        eval $(op signin hashicorp)
#        eval $(op signin my)
#        tmux attach -t TMUX || tmux new -s TMUX
#fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('~/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "~/anaconda3/etc/profile.d/conda.sh" ]; then
        . "~/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="~/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<
