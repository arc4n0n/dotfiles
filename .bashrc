# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='\n[$(date +%H:%M:%S)] ${debian_chroot:+($debian_chroot)}\[\033[01;30m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\nᛊ '
else
    PS1='\n[$(date +%H:%M:%S)] ${debian_chroot:+($debian_chroot)}\u@\h:\w\nᛊ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#alias .='ls'
alias ..='cd ..; ls'
alias -- -='cd -; ls'

alias brc='vim ~/.bashrc'
alias sbrc='source ~/.bashrc'

alias pf='printf'
alias pln="printf '\n'"

alias ?='defined'
defined() {
    alias "$1" 2>/dev/null || which "$1" || declare -f "$1" || echo -e "?"
}

alias inet='ipv4; echo "$(ipwsl) (WSL)"; echo "$(gateway) (Gateway)"'
alias ipv4='ipconfig.exe | grep "IPv4" -m 1 | cut -d":" -f 2 | tail -n1 | sed -e "s/\s*//g"'
alias gateway='ipconfig.exe | grep "Gateway" -A1 -m 1 | tail -n1 | sed -e "s/\s*//g"'
alias ipwsl='wsl.exe hostname -I'

alias jsonpp='python -m json.tool'

alias gl="git --no-pager log --pretty='format:%C(bold black)[%ad] %C(auto)%h %C(cyan)%an %C(reset)%s' -n25; pln"
alias gd='git --no-pager diff'
alias gdc='git --no-pager diff --cached'
alias gdf='git diff --name-status'
alias gst='git status'
alias gcm='git add -u; git commit -m'
alias gca='git add -u; git commit --amend --no-edit'
alias gau='git add -u; git status'
alias gpu='git push'
alias gbh='git rev-parse --short HEAD'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gb='git branch'

alias gmvt='go mod vendor; go mod tidy'

alias rl='sudo tail /var/log/redis/redis-server.log -n 100 -f'
alias rc='redis-cli -h localhost -p 6379 -a $REDIS_AUTH --no-auth-warning'

alias ssa='printf "\nSystem V\n"; service --status-all'
alias scs='printf "\nSystemD\n"; systemctl list-units --type=service --no-pager'
alias svs='ssa;scs'

alias fluentlogs='/opt/fluent-bit/bin/fluent-bit -i stdin -o http -c "/etc/fluent-bit/fluent-bit.conf"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

export GOROOT=/usr/local/go-1.18.3
export GOPATH=$HOME/projects/go
export GOBIN=$GOPATH/bin
export PATH=$GOROOT/bin:$PATH
export PATH=$HOME/projects/go/bin:$PATH

cd /mnt/c/Users/User/Documents/ᛊ


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
