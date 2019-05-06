#
# alias
#
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias -g ls='ls -F --color=auto'
alias -g ll='ls -l'
alias -g la='ls -A'
alias -g l.='ls -d .* --color=auto'
alias -g l='ls'
alias -g grep='grep --color=auto'
alias -g mkdir='mkdir -p'
alias -g vi='vim'
alias -s i=vi
alias -s h=vi
alias -s hh=vi
alias -s hpp=vi
alias -s inc=vi
alias -s def=vi
alias -s c=vi
alias -s C=vi
alias -s cc=vi
alias -s CC=vi
alias -s cpp=vi
alias -s cxx=vi
alias -s cs=vi
alias -s java=vi
alias -s asm=vi
alias -s s=vi
alias -s sh=vi
alias -s js=vi
alias -s rb=vi
alias -s txt=vi
alias -s text=vi
alias -s ini=vi
alias -s inf=vi
alias -s nfo=vi
alias -s log=vi
alias -s rc=vi
alias -s cnf=vi
alias -s conf=vi
alias -s config=vi
alias -s vim=vi
alias -s xml=vi
alias -s cmd=vi
alias -s bat=vi
alias -s sed=vi
alias -s pl=vi
alias -s py=vi
alias -s vb=vi
alias -s vbs=vi
alias -s dsm=vi
alias -s css=vi
alias -s php=vi
alias -s asp=vi
alias -s sql=vi
alias -s zshrc=vi
alias -s bashrc=vi
alias -s vssettings=vi
alias -s htm=Elinks
alias -s html=Elinks
alias -s png=pho
alias ai='yum install'
alias al='yum list'
alias e=w3m
alias qq="nohup google-chrome --no-proxy-server --app=http://web.qq.com >/dev/null 2>/dev/null &"
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
alias aqua='asciiquarium'


#
# common-options
#
bindkey -e   #Use Emacs Key bindings
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='mvim'
fi
limit coredumpsize 0  #disable core-dumps
setopt complete_in_word  #expand path: /v/c/p/p => /var/cache/pacman/pkg
zle_highlight=(region:bg=magenta special:bold isearch:underline)

# disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
# Watch other user login/out
watch=notme
export LOGCHECK=60

# [Shift-Tab] - move through the completion menu backwards
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

# history
export HISTSIZE=1000
export SAVEHIST=1000
setopt INC_APPEND_HISTORY  #write history record by appended method
setopt EXTENDED_HISTORY  #add timestamp for history record
setopt HIST_IGNORE_DUPS  #save only one if you type the same cmd again
setopt AUTO_PUSHD  #active history-func of cd: cd -[TAB]
setopt PUSHD_IGNORE_DUPS #save only one path if meet the same one


#
# autocompletement
#
setopt AUTO_LIST
setopt AUTO_MENU
setopt MENU_COMPLETE #auto-select menu when in completement mode
autoload -U compinit
compinit

# the order of completement
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

# color completement-menu
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# completement options
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect: lines: %L matches: %M [%p]'
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

# completement for path
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::complete:*' '\\'

# completement for kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

# prompt for group when completement
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'


#
# styler
#
autoload colors
colors

#
# prompt
#
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
	eval C_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval C_L_$color='%{$fg[${(L)color}]%}'
done
C_OFF="%{$terminfo[sgr0]%}"

set_prompt() {
	mypath="$C_OFF$C_L_YELLOW%~"
	myjobs=()
	for a (${(k)jobstates}) {
		j=$jobstates[$a];i="${${(@s,:,)j}[2]}"
		myjobs+=($a${i//[^+-]/})
	}
	myjobs=${(j:,:)myjobs}
	((MAXMID=$COLUMNS/2))
	RPS1="$RPSL$C_L_GREEN%$MAXMID<...<$mypath$RPSR"
	rehash
}
RPSL=$'$C_OFF'
RPSR=$'$C_OFF$C_L_RED%(0?.$C_L_GREEN. (%?%))$C_OFF'
RPS2='%^'
setopt promptsubst
unsetopt transient_rprompt

precmd() {
	set_prompt
	print -Pn "\e]0;%n@$__IP:%l\a"
}
PS1=$'[$C_L_GREEN%T $C_L_RED%(1j.<$myjobs>% $C_OFF .$C_OFF)$C_L_MAGENTA%m.%B%n%b$C_OFF]$C_L_RED%#$C_OFF '

#
# usefull functions & some settings come from bashrc
#
# keep screen always light
setterm -blank 0
# support 256 color
if [ "$TERM" = "linux" ]; then
    alias fbterm='LANG=zh_CN.UTF-8 fbterm'
    export TERM=xterm-256color
fi
# quick open tmux
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


#
# hilight cmd
#
setopt extended_glob
TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')
recolor-cmd() {
	region_highlight=()
	colorize=true
	start_pos=0
	for arg in ${(z)BUFFER}; do
		((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
		((end_pos=$start_pos+${#arg}))
		if $colorize; then
			colorize=false
			res=$(LC_ALL=C builtin type $arg 2>/dev/null)
			case $res in
			*'reserved word'*)   style="fg=magenta,bold";;
			*'alias for'*)       style="fg=cyan,bold";;
			*'shell builtin'*)   style="fg=yellow,bold";;
			*'shell function'*)  style='fg=green,bold';;
			*"$arg is"*)
			 [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
			*)                   style='none,bold';;
			esac
			region_highlight+=("$start_pos $end_pos $style")
		fi
		[[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
		start_pos=$end_pos
	done
}
check-cmd-self-insert() { zle .self-insert && recolor-cmd }
check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }
zle -N self-insert check-cmd-self-insert
zle -N backward-delete-char check-cmd-backward-delete-char
