### -*- shell-script -*-

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

#export-to-emacs () {
#    code=$(echo '(progn'
#        for var in "$@"; do
#            echo "(setenv \"$var\" \"${!var}\")"
#        done
#        echo ')')
#    emacsclient -e "$code" 1>/dev/null
#}
#
#emacs-ssh-agent () { export-to-emacs SSH_AGENT_PID SSH_AUTH_SOCK; }
#
nth () {
    local F=$1

    if [ $F == "-1" ]; then
        F="NF"
    fi

    awk "{ print \$$F }"
}

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

#load-keychain() { source ~/.keychain/${HOSTNAME}-sh; }

# return true if the host is pingable.
up? () { ping -c 1 -w 1 $1 >& /dev/null; }

# reload keychain
rk () { source ~/.keychain/$(hostname)-sh; }
