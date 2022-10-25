# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export TIME_STYLE="long-iso"

#export PATH="/usr/local/opt/openssl@3/bin:$PATH"
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
complete            -C aws_completer aws
alias k="kubectl" && source <(kubectl completion zsh) && compdef __start_kubectl k

# $ZSH/plugins
plugins=(git fzf-tab docker docker-compose tmux)
export ZSH="/Users/webdog/.oh-my-zsh"
fpath+=$ZSH/custom/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

CUSTOM=$HOME/.scripts
# functions
source $CUSTOM/shell.sh
source $CUSTOM/twitter.sh

# aliases
source $CUSTOM/aliases/aws.sh
source $CUSTOM/aliases/consul.sh
source $CUSTOM/aliases/gcp.sh
source $CUSTOM/aliases/jq.sh
source $CUSTOM/aliases/kube.sh
source $CUSTOM/aliases/shell.sh
source $CUSTOM/aliases/terraform.sh
source $CUSTOM/aliases/tmux.sh
source ~/.consulrc
source $CUSTOM/aliases/vagrant.sh
source $CUSTOM/markdown.sh
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# eval $(docker-machine env docker-debian-10)

