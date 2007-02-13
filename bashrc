### -*- shell-script-mode -*-

export CDPATH=".:~"
export CVS_RSH=ssh
export HISTIGNORE="&:mutt:[bf]g:exit"
export LESS="XR"
export PERL5LIB=${HOME}/lib/perl5
export RI="-f ansi"

# from The (Almost) Perfect Backspace Solution
stty erase `tput kbs`

### prompt fancyness
function prompt_char() {
    local char

    if [ $(id -g) -ne 0 ]; then
	char='>'
    else
	char='#'
    fi
    
    echo -n $char
}

function prompt() {
    local GREEN="\[\033[0;32m\]"
    local MAGENTA="\[\033[0;35m\]"
    local RED="\[\033[0;31m\]"
    local YELLOW="\[\033[0;33m\]"
    local NOCOLOR="\[\033[0m\]"

    local HOST_COLOR=$RED

    local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`

    if [ $SSH_IP ]; then
	HOST_COLOR=$MAGENTA
    fi

    echo "$GREEN[$NOCOLOR\t$GREEN]$NOCOLOR $YELLOW{$NOCOLOR\u@$HOST_COLOR\h$NOCOLOR:\w$YELLOW}$NOCOLOR \$(prompt_char) "
}

export PS1=$(prompt)
export PS2='->'

set -o emacs
set -o ignoreeof

OPTIONS="extglob progcomp cdspell cmdhist checkwinsize histreedit histverify lithist"
for option in $OPTIONS; do
    shopt -s $option
done
unset OPTIONS

alias cl="clear"
alias h="history"
alias jobs="jobs -l"
alias mv="mv -i"
alias rm="rm -i"

##OS specific configuration
case $OSTYPE in
    darwin*)
	## use fink if it's installed
	FINKINIT=/sw/bin/init.sh
	if [ -e $FINKINIT ]; then
	    . $FINKINIT
	fi

	## use darwin ports if it's here
	if [ -d /opt/local/bin ]; then
	    export PATH=/opt/local/bin:$PATH
	fi

	if [ -d /opt/local/man ]; then
	    export MANPATH=/opt/local/man:$MANPATH
	fi

	# turn on color ls 
	export CLICOLOR='on'

	alias top="top -u"
	;;
    linux*)
	alias grep="grep --color=auto"
	;;
esac

### functions

# print PATH in a more readable format
# handles any PATH like variable, but defaults to PATH
function lspath () {
    local var=${1:-"PATH"}
    echo -e ${!var//:/\\n}
}
	
# clear history
function hcl () {
    size=$HISTSIZE
    export HISTSIZE=0
    export HISTSIZE=$size
}

function hgrep () {
    history | grep "$*"
}

function cprove() {
    cover -delete
    PERL5OPT=-MDevel::Cover prove "$*"
    cover
}

function pmversion() {
    perl -e "require $1; print $1->VERSION, \"\\n\""
}

## setup bash completions if we can find it.
locations="/etc/bash_completion /opt/local/etc/bash_completion /sw/etc/bash_completion"
for bash_completion in $locations; do
    if [ -f $bash_completion ]; then
	. $bash_completion
    fi
done
unset locations
