# .bashrc

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias ls='ls -F --color=auto'
alias ll='ls -lhrtF --color=auto'
alias la='ls -A --color=auto'
alias l.='ls -d --color=auto .*'
alias l='ls -F --color=auto'
alias vi='vim'
alias ai='yum install'
alias ar='yum remove'
alias al='yum list'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias aqua='asciiquarium'
alias e=w3m
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# customize command prompt
PS1="[\[\e[32m\]\t \[\e[33m\]\u \[\e[35m\]\w\[\e[m\]]\\$ "

# keep screen always light
setterm -blank 0

# support 256 color
if [ "$TERM" = "linux" ]; then
    alias fbterm='LANG=zh_CN.UTF-8 fbterm'
    export TERM=xterm-256color
fi

# tmux shortcut
tm() {
    cmd=$(which tmux)
    session_name=leiz
    topname=top
    [ -e /usr/bin/htop ] && topname=htop
    if [ -z $cmd ]; then
        echo "You need to install tmux!"
        return 1
    fi
    $cmd has-session -t $session_name
    if [ $? != 0 ]; then
        $cmd new-session -d -s $session_name -n "window-name"
        $cmd split-window -h
        $cmd split-window -v "exec ${topname}"
        $cmd select-pane -t 2
        $cmd -2 attach-session -d
    else
        $cmd attach
    fi
}

