#!/bin/bash

VPNDIR=~/mps/vpn/
cd "$VPNDIR" || exit 1

CMD="status"
NAME=""
CONFFILE=""
PIDFILE=""
GREPTEXT="openvpn --daemon --config"
if [[ $# -eq 1 ]] ; then
    CMD="toggle"
    NAME="$1"
    CONFFILE="./$1.conf"
    PIDFILE="./$1.pid"
    GREPTEXT="openvpn --daemon --config ./$1.conf"
elif [[ $# -eq 2 ]] ; then
    CMD="$1"
    NAME="$2"
    CONFFILE="./$2.conf"
    PIDFILE="./$2.pid"
    GREPTEXT="openvpn --daemon --config ./$2.conf"
fi

stopvpn() {
    if [[ -f "$PIDFILE" ]] ; then
        PID=$(cat "$PIDFILE")
        echo "Stopping running instance ('$NAME') with pid $PID"
        sudo kill "$PID"
        sudo rm -rf "$PIDFILE"
    fi
}

startvpn() {
    if [[ -f "$CONFFILE" ]] ; then
        echo "starting new instance ('$NAME')"
        sudo openvpn --daemon --config "$CONFFILE"
        PID=$(pgrep -f "$GREPTEXT")
        echo "$PID" >"$PIDFILE"
    fi
}

togglevpn() {
    PID=$(pgrep -f "$GREPTEXT")
    if [[ -z "$PID" ]] ; then
        startvpn
    else
        stopvpn
    fi
}

statusvpn() {
    PID=$(pgrep -f "$GREPTEXT")
    if [[ -z "$PID" ]] ; then
        echo "Instance ('$NAME') is down"
    else
        echo "Instance ('$NAME') is up"
    fi
}
statusvpnall() {
    for f in ./*.conf ; do
        NAME=$(basename "$f" .conf)
        PID=$(pgrep -f "openvpn --daemon --config $f")
        if [[ -z "$PID" ]] ; then
            echo "Instance ('$NAME') is down"
        else
            echo "Instance ('$NAME') is up"
        fi
    done
}

if [[ $# -eq 0 ]] ; then
    statusvpnall
    exit 0
fi
if [[ "$CMD" == "start" ]] ; then
    stopvpn
    startvpn
elif [[ "$CMD" == "stop" ]] ; then
    stopvpn
elif [[ "$CMD" == "toggle" ]] ; then
    togglevpn
elif [[ "$CMD" == "status" ]] ; then
    if [[ $# -eq 1 ]] ; then
        statusvpnall
    else
        statusvpn
    fi
else
    echo "Unknown command!"
fi
