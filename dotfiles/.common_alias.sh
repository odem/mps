#!/bin/bash
#
# apt
alias pq='apt search'
alias pi='sudo apt install'
alias pd='sudo apt remove'
alias puu='sudo apt update && sudo apt upgrade'
alias cmmi='./configure && make && sudo make install'

# ls
alias zz='z -'
alias zq='zoxide query'

# ls
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias sll='sudo ls -la'

# exa
alias e='exa'
alias et='exa --long --tree'
alias ee='exa -abghHlS'
alias eet='exa --long --tree -abghHlS'
alias see='sudo exa -abghHlS'
alias stree='sudo exa --long --tree'

# Skeletons
alias skel='new-skeleton.bash'

# custom scripts
alias rfs='~/mps/snippets/rfs.bash'
alias vff='nvim $(~/mps/snippets/fuzzy-find.bash)'
alias ela='~/mps/snippets/elapsed.bash'
alias cheat='~/mps/snippets/chtsht.bash'

# cat
alias bcat='batcat'
alias scat='sudo cat'
alias sbcat='sudo batcat'

# cp
alias rp='rsync -arvP --info=progress2'

# Battery
alias battery='upower -i $(upower -e | grep BAT) | grep --color=never -E "state|to\ full|to\ empty|percentage"'

# git
alias gs='git status'
alias gss='git status -sb'
alias gl='git log --pretty=oneline'
alias gll='git log'
alias gd='git diff'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m'
alias gsl='git stash list'
alias gstash='git stash save wip'
alias gstashpop='bucket=$(git stash list | grep wip | awk "{print $1}" | cut -f 1 -d ":") ; [ ! -z "$bucket" ] && git stash pop "$bucket" || echo "NO"'
alias gpull='git pull'
alias gpush='git push'
# Docker
alias dps="docker ps -a"
alias dcexec="docker exec -ti "
alias dcstop="docker container stop "
alias dckill="docker container kill "
alias dcrm="docker container rm"
alias dnls="docker network ls"
alias dvls="docker volume ls"
alias dirm="docker image rm"
alias dia="docker images -a"
alias diatagged='docker images -a | grep -v "<none>"'

# ps
alias psag="ps aux | grep "
# network
alias ns='sudo netstat -tulpn |sort -k 4 -n'
alias nso='sudo netstat -tulpano |sort -k 4 -n'

# ifconfig
alias sif='sudo ifconfig'
alias sifa='sudo ifconfig -a'
alias sifab='sudo ifconfig -a | grep --color=never ^br'
alias sifap='sudo ifconfig -a | grep --color=never ^tap'
alias sifan='sudo ifconfig -a | grep --color=never ^tun'
alias sifar='sudo ifconfig -a | grep --color=never -Ev "^(br|tap|tun)"'
alias lip='sudo ip -4 addr show scope global | awk '\''/^[0-9]/ {if (iface) {print iface " " (ips ? ips : "No IP");} iface=$2; ips=""; next} /inet / {ips = (ips ? ips ", " : "") $2} END {if (iface) print iface " " (ips ? ips : "No IP")}'\'' | sort'
alias lipa='sudo ip addr | awk '\''/^[0-9]/ {if (iface) {print iface " " (ips ? ips : "No IP");} iface=$2; ips=""; next} /inet / {ips = (ips ? ips ", " : "") $2} END {if (iface) print iface " " (ips ? ips : "No IP")}'\'' | sort'

# iptables
alias iptl='sudo iptables -L -vn '
alias iptln='sudo iptables -L -t nat -vn '
alias iptla='sudo iptables -L -vn ; echo "" ; sudo iptables -L -t nat -vn '

# bridge
alias sbs='sudo brctl show'

# routing
alias srn='sudo route -n'

# systemctl
alias scstatus='sudo systemctl status '
alias scstart='sudo systemctl start '
alias scstop='sudo systemctl stop '
alias screstart='sudo systemctl restart '
alias screload='sudo systemctl daemon-reload'

# nvim
alias v='~/mps/secrets/chatgpt-token.bash && nvim'
alias sv='sudo nvim'
# mps
alias mps="z ~/mps"
alias disks="z ~/mps/disks"
alias docs="z ~/mps/docs"
alias iso="z ~/mps/iso"
alias repo="z ~/mps/repo"
alias scratch="z ~/mps/scratch"
alias secrets="z ~/mps/secrets"
alias skeletons="z ~/mps/skeletons"
alias snippets="z ~/mps/snippets"
alias tools="z ~/mps/tools"
alias venv="z ~/mps/venv"
alias vm="z ~/mps/vm"
alias wsp="z ~/mps/wsp"

# More fancy colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Quick script for launching virtual machines with qemu
alias qvm_install="quickvm.bash -a install"
alias qvm_clone="quickvm.bash -a clone"
alias qvm_delete="quickvm.bash -a delete"
alias qvm_start="quickvm.bash -a start"
alias qvm_stop="quickvm.bash -a stop"
alias qvm_list="quickvm.bash -a list"
alias qvm_ssh="quickvm.bash -a ssh"

# xset
alias xx="xset r rate 250 50"

# vpn
alias vpn-ptp="vpn.bash ptp"
alias vpn-bridge="vpn.bash bridge"
alias vpn-state="vpn.bash"

# public ip
alias whoamip='echo $(curl -s ifconfig.me)'

# tmux session control
alias tls="tmux ls"
alias tas="tmux attach -t "
alias tns="tmux new -s "
alias tks="tmux kill-session -t "

# Custom config aliases
alias cfg-qtile="nvim ~/.config/qtile/config.py"
alias cfg-nvim="nvim ~/.config/nvim/init.lua"
alias cfg-tmux="nvim ~/.config/tmux/tmux.conf.local"
alias cfg-kitty="nvim ~/.config/kitty/kitty.conf"
alias cfg-ssh="nvim ~/.ssh/config"
alias cfg-snippets="nvim ~/mps/snippets"
alias cfg-skeletons="nvim ~/mps/skeletons"
alias cfg-autostart="nvim \$(which autostart.sh)"
alias cfg-backup="nvim \$(which backup.bash)"
alias cfg-bashrc="nvim ~/.bashrc && source ~/.bashrc"
alias cfg-zshrc="nvim ~/.zshrc && source ~/.zshrc"
alias cfg-alias-common="nvim ~/.common_alias.sh && source ~/.common_alias.sh"
alias cfg-alias-custom="nvim ~/.custom_alias.sh && source ~/.custom_alias.sh"


# mount
alias smountall='sudo mount -a'
alias smount='sudo mount'
alias sdf='sudo df -h | pee "head -n 1" "tail -n +2" | sort'
alias sdfa='sudo df -ah | pee "head -n 1" "tail -n +2" | sort'

# Lock screen
alias lock="physlock"

# Custom folders aliases
alias mpsrepo="z /opt/mps"

# Include more custom aliases
. ~/.custom_alias.sh



# Testing
each_line() {
  cmd_prefix="$1"
  cmd_trail="$2"

  while IFS= read -r line; do
    if [[ -z "$cmd_trail" ]]; then
      eval "$cmd_prefix \"$line\""
    else
      eval "$cmd_prefix \"$line\" $cmd_trail"
  fi
  done
}  
