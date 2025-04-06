#!/bin/bash

HAS_TMP=$(grep -c "tmpfs /tmp tmpfs" /etc/fstab)
if [[ $HAS_TMP -eq 0 ]] ; then
    echo "Moving /tmp to ramdisk"
    sudo rm -rf /tmp 2>/dev/null
    sudo mkdir /tmp 2>/dev/null
    sudo umount /tmp 2>/dev/null
    cat <<EOF | sudo tee --append /etc/fstab
# ramdisk /tmp
tmpfs /tmp tmpfs mode=1777,nosuid,nodev 0 0
EOF
    sudo systemctl daemon-reload
    sudo mount -a
fi
HAS_VARLOG=$(grep -c "tmpfs /var/log tmpfs" /etc/fstab)
if [[ $HAS_VARLOG -eq 0 ]] ; then
    echo "Moving /var/log to ramdisk"
    sudo umount /var/log 2>/dev/null
    sudo mv /var/log  /tmp/log 2>/dev/null
    sudo mkdir /var/log 2>/dev/null
    cat <<EOF | sudo tee --append /etc/fstab
# ramdisk /var/log
tmpfs /var/log tmpfs mode=1777,nosuid,nodev 0 0
EOF
    sudo systemctl daemon-reload
    sudo mount -a
    sudo cp -r /tmp/log/* /var/log
    sudo rm -rf /tmp/log
fi
