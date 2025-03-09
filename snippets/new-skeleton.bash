#!/bin/bash
SKELDIR=~/mps/skeletons
ACTION="ls"
NAME=""
DEST="."
usage() {
    echo ""
    echo "Usage:"
    echo "  $0 -a ACTION [PARAM_1, PARAM_2, PARAM_N, ...]"
    echo ""
    echo "  Actions:"
    echo "    ls        :   List templates [Default]"
    echo "    cp        :   Copy template"
    echo ""
    echo "  Params:"
    echo "    -n NAME        :   Template name       [Default: '']"
    echo "    -d DEST        :   Destination folder  [Default: .]"
    echo ""
}
while getopts "h a:n:d:" o; do
    case "$o" in
        a)
            ACTION=${OPTARG}
            ;;
        n)
            NAME=${OPTARG}
            ;;
        d)
            DEST=${OPTARG}
            ;;
        h)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: '${OPTARG}'"
            echo "Aborting..."
            exit 2
            ;;
    esac
done

do_ls() {
    for i in "$SKELDIR"/* ; do
        [[ -e "$i" ]] || break
        [[ -d $i ]] && echo "Dir -Template: ${i##*/}"
        [[ -f $i ]] && echo "File-Template: ${i##*/}"
    done;
}
do_cp() {
    [[ -z "$NAME" ]] && echo "Name is empty!" && usage && exit 1
    [[ ! -d "$DEST" ]] && echo "Destination given is not valid: '$DEST'" && usage && exit 2
    if [[ -f "$SKELDIR/$NAME" ]]; then
        echo "Copy File-Template '$NAME' to '$DEST'"
        cp -v "$SKELDIR/$NAME" "$DEST"
    elif [[ -d "$SKELDIR/$NAME" ]]; then
        echo "Copy Dir-Template '$NAME' to '$DEST'"
        cp -v -r "$SKELDIR/$NAME"/* "$DEST"
    else
        echo "Template does not exist: '$NAME'"
    fi
}
case "$ACTION" in
    "ls")
        do_ls
        ;;
    "cp")
        do_cp
        ;;
     *)
        echo "Not a valid target: $1"
        ;;
esac

