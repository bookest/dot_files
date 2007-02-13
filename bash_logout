### -*- shell-script -*-

# invalidate the gpm selection buffer iff logging out from a virtual
# terminal
if [ -x /sbin/consoletype ] && /sbin/consoletype fg; then
    pidfile=/var/run/gpm.pid
    if [ -r $pidfile ] && [ -d "/proc/$(/bin/cat $pidfile)" ]; then
        kill -USR2 "$(/bin/cat $pidfile)"
    fi
fi
 
