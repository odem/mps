#!/bin/bash

_bw_unlock() {
    local cache_file="${HOME}/.cache/kpm.session"

    [[ -f "$cache_file" ]] && source "$cache_file"
    bw unlock --check &>/dev/null
    if [[ $? -ne 0 ]]; then
        (bw login --check &>/dev/null || bw login --apikey) && bw sync -f &>/dev/null
        BW_SESSION="$(bw unlock --raw)"
        export BW_SESSION
        mkdir -p "$(dirname "$cache_file")"
        echo "export BW_SESSION=\"${BW_SESSION}\"" >"$cache_file"
        echo "Session created"
        return 0
    else
        echo "Session already created"
        return 0
    fi
}
_bw_choose() {
    elements=$(bw list items \
        | jq -r 'map(select(.type == 1)) | .[] | "\(.name) \(.login.username) \(.login.password)"')
    echo "$elements" | column -t \
        | awk '{print $1, $2, $3}' \
        | fzf -e --with-nth=1 \
            --nth=1 \
            --delimiter=' ' \
            --preview='echo {1} {2}' \
            --preview-window='hidden' \
            --no-hscroll \
            --cycle \
            --layout=reverse \
            --info=inline \
            --header='Select Tresor element' \
            --query '' \
        | awk '{print $3}'
}
_bw_unlock
pw=$(_bw_choose)
[[ -n "$pw" ]] && echo "GOT PW"
[[ -n "$pw" ]] && echo "$pw" | kitty @ send-text -m id:"$1" --stdin

