# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Import functions
ZDOTDIR=~/.config/zsh
fpath+=${ZDOTDIR:-~}/zsh_functions

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="hckr"

export LESS=' -R --quit-if-one-screen --no-init'
export MORE=' -R --quit-if-one-screen --no-init'

#
### PLUGINS ###
#
plugins=(git oh-my-git battery mvn systemd ubuntu docker sudo fzf fzf-z terraform)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
PATH=$PATH:$HOME/.config/scripts
export ZSH_CUSTOM="~/workspace/dotfiles/zsh"
#!/bin/bash

if [  -f $HOME/.zshrc.custom ]; then
    source $HOME/.zshrc.custom
fi

#alias mkdircd="mkdir $1 && cd $1"
alias vi='vim'
alias ls='ls -GFlh'
alias gzip=pigz
alias wip='git co -m wip'
alias amend='git amend'
alias got='git'
alias mci='mvn clean install'
alias dcqlsh='docker exec -it $(docker ps -qf "name=cassandra") cqlsh'
alias more='less'
alias dps='docker ps --format "{{ .ID }}\t{{ .Image }}\t{{ .Ports }}"'
alias night='redshift'
alias mvnup='mvn versions:display-property-updates versions:display-dependency-updates versions:display-plugin-updates -DgenerateBackupPoms'
alias dose=docker-compose
alias gw='./gradlew'
alias tf='terraform'
alias gs='gst'
alias boseon='echo "connect 60:AB:D2:31:DD:C1" | bluetoothctl'
alias boseoff='echo "disconnect 60:AB:D2:31:DD:C1" | bluetoothctl'
alias capsoff='setxkbmap -option caps:none'
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias icat='kitty +kitten icat'

source $ZSH/oh-my-zsh.sh

if [[ -f "$HOME/software/z/z.sh" ]]; then
	. $HOME/software/z/z.sh
fi

if [[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    alias java13='sdk use java 13.0.1.hs-adpt'
    alias jdk13=java13
    alias java11='sdk use java 11.0.10-open'
    alias jdk11=java11
    alias java8='sdk use java 8.0.282-open'
    alias jdk8=java8
    alias java14='sdk use java 14.0.0-open'
    alias jdk14=java14
fi

eval $(thefuck --alias zut) 

export FZF_BASE=/home/aboivin/.fzf/
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LANG=en_US.UTF-8

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2>/dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
export FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_CTRL_C_COMMAND="fd --type d $FD_OPTIONS"

export GOPATH=$HOME/go

if [[ -f "$HOME/software/go/bin/go" ]]; then
	export PATH=$PATH:$HOME/software/go/bin:$GOPATH/bin
fi

if [[ -f "$HOME/software/node/bin/node" ]]; then
	export PATH=$PATH:$HOME/software/node/bin
fi

NODE_HOME="$HOME/software/$(ls -1 ~/software | grep node | sort | tail -1)"
if [[ -f $NODE_HOME/bin/node ]]; then
        export PATH=$PATH:$NODE_HOME/bin
fi

if [[ -f "$HOME/gems" ]]; then
	GEM_HOME=$HOME/gems
        export PATH=$PATH:$HOME/gems/bin
fi

#IDEA_HOME="$HOME/software/$(ls -1 ~/software | grep idea | sort | tail -1)"
#if [[ -f $IDEA_HOME/bin/idea.sh ]]; then
#	export PATH=$PATH:$IDEA_HOME/bin
#	alias idea=idea.sh
#fi

if [ -f $HOME/.cargo/env ]; then
    source $HOME/.cargo/env
    alias ls='exa -GFlh'
    alias ll='exa -lh'
    alias l='ll'
fi

if [ -f $HOME/software/packer/packer ]; then
    PACKER_HOME=/home/aboivin/software/packer
    PATH=$PATH:$PACKER_HOME
fi    

