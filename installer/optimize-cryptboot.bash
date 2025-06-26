#!/bin/bash

LUKS_PART=/dev/vda4
LUKS_PASS=diskpass
LUKS_VERSION=$(sudo cryptsetup luksDump $LUKS_PART \
    | grep "Version: " \
    | tr -d "\t " | cut -d ":" -f 2)

create_initramfs_breakpoint() {
    echo "Create initramfs breakpoint"
    sudo sed "/GRUB_CMDLINE_LINUX_DEFAULT/d" -i /etc/default/grub
    echo 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash break=mount"' | sudo tee --append /etc/default/grub
    sudo update-grub
}
remove_initramfs_breakpoint() {
    echo "Remove initramfs breakpoint"
    sudo sed "/GRUB_CMDLINE_LINUX_DEFAULT/d" -i /etc/default/grub
    echo 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' | sudo tee --append /etc/default/grub
    sudo update-grub
}
create_initramfs_hook() {
    echo "Create initramfs hook"
    cat <<EOF | sudo tee --append /etc/initramfs-tools/scripts/init-premount/run_once.sh
#!/bin/sh
printf "$LUKS_PASS\n" | cryptsetup luksConvertKey --pbkdf pbkdf2 "$LUKS_PART"
printf "YES\n" | cryptsetup convert --type luks1 "$LUKS_PART"
sleep 3
cryptsetup luksDump "$LUKS_PART" | grep "Version: "
#rm -rf /etc/initramfs-tools/scripts/init-premount/run_once.sh
exit
EOF
    sudo chmod a+x /etc/initramfs-tools/scripts/init-premount/run_once.sh
    sudo update-initramfs -u
    # printf "\n\n\n" | sudo update-initramfs -u
}
move_boot() {
    echo "Move boot dir"
    HAS_BOOT=$(grep -c " /boot " /etc/fstab)
    [[ $HAS_BOOT -eq 0 ]] && return 0
    sudo mount -o remount,ro /boot
    sudo cp -axT /boot /boot.tmp
    sudo umount /boot/efi && sudo umount /boot
    sudo rmdir /boot
    sudo mv -T /boot.tmp /boot
    sudo mount /boot/efi
    sudo sed "/ \/boot /d" -i /etc/fstab
    echo "GRUB_ENABLE_CRYPTODISK=y" | sudo tee --append /etc/default/grub
    sudo umount /boot
    sudo update-grub
    sudo grub-install "$DISK_PART"
    sudo rm -rf /boot.tmp
    #sudo shutdown -r now
}
add_keyfile() {
    echo "Add keyfile"
    HAS_BOOT=$(grep -c " /boot " /etc/fstab)
    [[ $HAS_BOOT -gt 0 ]] && return 0
    HAS_KEYFILE=$(grep -c "/keyfile" /etc/crypttab)
    [[ $HAS_KEYFILE -gt 0 ]] && return 0
    sudo dd bs=512 count=4 if=/dev/random of=/keyfile iflag=fullblock
    sudo chmod 0600 /keyfile
    sudo cryptsetup luksAddKey "$LUKS_PART" /keyfile
    sudo cryptsetup luksDump "$LUKS_PART"
    sudo sed "s# none luks,discard# /keyfile luks,discard,key-slot=1#g" -i /etc/crypttab
    echo 'KEYFILE_PATTERN="/keyfile"' | sudo tee --append /etc/cryptsetup-initramfs/conf-hook
    echo UMASK=0077 | sudo tee --append /etc/initramfs-tools/initramfs.conf
    rm -rf /etc/initramfs-tools/scripts/init-premount/run_once.sh
    sudo update-initramfs -u -k all
}

echo "LUKS_VERSION: $LUKS_VERSION"
sleep 5
if [[ "$LUKS_VERSION" == "2" ]] ; then
    echo "Luks version is 2"
    create_initramfs_breakpoint
    create_initramfs_hook
elif [[ "$LUKS_VERSION" == "1" ]] ; then
    if [[ ! -f /keyfile ]] ; then
        echo "Luks version is 1"
        remove_initramfs_breakpoint
        move_boot
        add_keyfile
    fi
else
    echo "Unknown Error! Could not detect luks version: $LUKS_VERSION"
fi
