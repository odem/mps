#!/bin/bash
function netinfo { 
    read -r _{,} gateway _ iface _ ip _ < <(ip r g 1.0.0.0)
    printf "%-13s: %s\n" LAN1 "$iface  ($ip via $gateway)"
}
function meminfo { 
    STR_MEM=$(free -m -h -t | grep 'Total:\|Gesamt:' | cut -d":" -f2 | xargs)
    STR_TOT=$(echo $STR_MEM | cut -d" " -f1)
    STR_USED=$(echo $STR_MEM | cut -d" " -f2)
    STR_FREE=$(echo $STR_MEM | cut -d" " -f3)
    printf "%-13s: %s\n" Memory "Total: $STR_TOT Used: $STR_USED Free: $STR_FREE"
}
function cpuinfo { 
    STR_ARCH=$(lscpu | grep Architecture | cut -d":" -f2 | xargs)
    STR_MODEL=$(lscpu | grep "Model name:" | cut -d":" -f2 | xargs)
    STR_NUMCPU=$(lscpu | grep -e "^CPU(s):" | cut -d":" -f2 | xargs)
    STR_MEM=$(free -m -h -t | grep Total: | cut -d":" -f2 | xargs)
    printf "%-13s: %s\n" CPU "$STR_MODEL ($STR_ARCH)"
}
function kernelinfo {
    STR_KERNEL=$(uname -v)
    printf "%-13s: %s\n" Kernel "$STR_KERNEL"

}
cpuinfo
meminfo
kernelinfo
netinfo
