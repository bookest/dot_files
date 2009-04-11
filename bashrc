### -*- shell-script -*-

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export CVS_RSH=ssh
export HISTIGNORE="&:mutt:[bf]g:exit"
export INPUTRC=${HOME}/.inputrc
export PAGER=less
export LESS="XR"
export PERL5LIB=${HOME}/lib/perl5
export PYTHONPATH=${HOME}/lib/python
export RUBYOPT=rubygems
export RI="-f ansi"

CDPATH=".:~:${HOME}/devel:${HOME}/work"

if [ ! -z $TERM -a $TERM != 'dumb' ]; then
    # from The (Almost) Perfect Backspace Solution
    stty erase `tput kbs`

    _parse_branch () {
        type git >& /dev/null || return
        git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
    }
    
    ### prompt fanciness
    _prompt () {
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
        
        echo "${GREEN}[${NOCOLOR}\!${GREEN}]${NOCOLOR}" \
             "${GREEN}{${NOCOLOR}\t${GREEN}}${NOCOLOR}" \
             "${YELLOW}<${NOCOLOR}\u@${HOST_COLOR}\h${NOCOLOR}:\w${YELLOW}>" \
             "${GREEN}\$(_parse_branch)${NOCOLOR}\$ "
    }
    
    export PS1=$(_prompt)
    export PS2='-> '
fi

set -o emacs
set -o ignoreeof

OPTIONS="extglob progcomp cdspell cmdhist checkwinsize histappend histreedit histverify lithist"
for option in $OPTIONS; do
    shopt -s $option
done
unset OPTIONS

alias la="ls -a"
alias ll="ls -l"
alias cl="clear"
alias h="history"
alias jobs="jobs -l"
alias mv="mv -i"
alias rm="rm -i"
alias g="git"

# use color if grep supports it...
if grep --help | grep -- --color &> /dev/null; then
    export GREP_OPTIONS='--color=auto'
fi

##OS specific configuration
case $OSTYPE in
    darwin*)
        ## use darwin ports if it's here
        if [ -d /opt/local/bin ]; then
            export PATH=/opt/local/bin:$PATH
        fi

        if [ -d /opt/local/man ]; then
            export MANPATH=/opt/local/man:$MANPATH
        fi

        export CLICOLOR='on'           # color ls 
        export COMMAND_MODE='unix2003' # no legacy mode on leopard

        alias top="top -u"
        ;;
esac

### functions

# print PATH in a more readable format. handles any PATH like
# variable, but defaults to PATH
lspath () {
    local var=${1:-"PATH"}
    echo -e ${!var//:/\\n}
}

# clear history
hcl () {
    size=$HISTSIZE
    export HISTSIZE=0
    export HISTSIZE=$size
}

cprove() {
    cover -delete
    PERL5OPT="-MDevel::Cover" prove "$@"
    cover
}

pmversion () { perl -le "require $1; print $1->VERSION"; }

ipsort () { sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 "$@"; }

if which rpm2cpio >& /dev/null; then
    lsrpm () { rpm2cpio $1 | cpio -t; }

    xrpm () {
        local pkg=$1
        shift
        rpm2cpio $pkg | cpio -ivd "$@"
    }
fi

cleanenv () {
    /usr/bin/env -i PATH=/usr/bin:/bin:/usr/X11R6/bin:/usr/sbin:/sbin \
                    HOME=$HOME \
                    TERM=$TERM \
                    "$@"
}

rpmbuild () { cleanenv /usr/bin/rpmbuild "$@"; }

dired () {
    local dir=${1:-$PWD}
    emacsclient -n -e "(dired \"$dir\")"
}

ediff () { emacsclient -n -e "(ediff \"$1\" \"$2\")"; }

export-to-emacs () {
    code=$(echo '(progn'
        for var in "$@"; do
            echo "(setenv \"$var\" \"${!var}\")"
        done
        echo ')')
    emacsclient -e "$code" 1>/dev/null
}

emacs-ssh-agent () { export-to-emacs SSH_AGENT_PID SSH_AUTH_SOCK; }

nth () { awk "{ print \$$1 }"; }

# Display a growl notification using iTerm's magic escape sequence.
growl() {
    local msg="\\e]9;\n\n${*}\\007"
    case $TERM in
        screen*)
            echo -ne '\eP'${msg}'\e\\' ;;
        *)
            echo -ne ${msg} ;;
    esac
    return
}

## setup bash completions if we can find it.
for f in {,/opt/local,${HOME}/local}/etc/bash_completion $HOME/.bash_completion; do
    if [ -r $f ]; then
        . $f
        break
    fi
done
unset f
