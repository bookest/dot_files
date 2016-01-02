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

CDPATH=".:~:${HOME}/projects:${HOME}/Documents"

if [ ! -z "$TERM" ] && [ "$TERM" != 'dumb' ]; then
    # from The (Almost) Perfect Backspace Solution
    stty erase "$(tput kbs)"

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

        local SSH_IP=$(echo $SSH_CLIENT | awk '{ print $1 }')

        if [ "$SSH_IP" ]; then
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

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist histappend histreedit histverify lithist
shopt -s extglob
shopt -s progcomp

alias la="ls -a"
alias ll="ls -l"
alias cl="clear"
alias h="history"
alias jobs="jobs -l"
alias mv="mv -i"
alias rm="rm -i"
alias g="git"
alias be="bundle exec"
alias ag="ag --pager=\${PAGER:-less}"

# use color if grep supports it...
if grep --help 2>&1 | grep -- --color &> /dev/null; then
    export GREP_OPTIONS='--color=auto'
fi

##OS specific configuration
case $OSTYPE in
    darwin*)
        ## use macports if it's here
        for d in /opt/local $HOME/local; do
            if [ -d $d/bin ]; then
                export PATH=$d/bin:$PATH
            fi

            if [ -d $d/man ]; then
                export MANPATH=$d/man:$MANPATH
            fi
        done

        export CLICOLOR='on'           # color ls
        export COMMAND_MODE='unix2003' # no legacy mode on leopard

        alias top="top -u"
        ;;
esac

if [ -x "$HOME/bin/e" ]; then
    export EDITOR=$HOME/bin/e

    # Use terminal mode by default if we're on a remove host.
    if [ ! -z "${SSH_CLIENT}" ]; then
        export EDITOR="${EDITOR} -t"
    fi
fi

if [ -r ~/.bash_functions ]; then
    source ~/.bash_functions
fi

## setup bash completions if we can find it.
for f in {,/usr/local}/etc/bash_completion; do
    if [ -r $f ]; then
        . $f
        break
    fi
done
unset f

complete -C aws_completer aws

if [ -s "$HOME/.bash_local" ]; then
    source "$HOME/.bash_local"
fi

if type rbenv >& /dev/null; then
    eval "$(rbenv init -)"
fi

if type virtualenvwrapper.sh >& /dev/null; then
    source virtualenvwrapper.sh
fi

if [ -x "${HOME}/.chefvm/bin/chefvm" ]; then
    eval "$(${HOME}/.chefvm/bin/chefvm init -)"
fi

if [ -x "${HOME}/.cask/bin/cask" ]; then
    export PATH="${HOME}/.cask/bin:$PATH"
fi

if [ -d "${HOME}/projects/go" ]; then
    export GOPATH="${HOME}/projects/go"
    export PATH="${PATH}:${GOPATH}/bin"
fi

if type stack >& /dev/null; then
    eval "$(stack --bash-completion-script "$(which stack)")"
    export PATH="${HOME}/.local/bin:${PATH}"
fi

if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)"
fi
