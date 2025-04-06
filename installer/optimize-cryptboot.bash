#!/bin/bash

LUKS_PART=/dev/vda3
LUKS_PASS=diskpass
LUKS_VERSION=$(sudo cryptsetup luksDump $LUKS_PART \
    | grep "Version: " \
    | tr -d "\t " | cut -d ":" -f 2)

create_initramfs_breakpoint() {
    sudo sed "/GRUB_CMDLINE_LINUX_DEFAULT/d" -i /etc/default/grub
    echo 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash break=mount"' | sudo tee --append /etc/default/grub
    sudo update-grub
}
remove_initramfs_breakpoint() {
    sudo sed "/GRUB_CMDLINE_LINUX_DEFAULT/d" -i /etc/default/grub
    echo 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' | sudo tee --append /etc/default/grub
    sudo update-grub
}
create_initramfs_hook() {
    cat <<EOF | sudo tee --append /etc/initramfs-tools/scripts/init-premount/run_once.sh
#!/bin/sh
printf "$LUKS_PASS\n" | cryptsetup luksConvertKey --pbkdf pbkdf2 "$LUKS_PART"
printf "YES\n" | cryptsetup convert --type luks1 "$LUKS_PART"
sleep 3
cryptsetup luksDump "$LUKS_PART" | grep "Version: "
rm -rf /etc/initramfs-tools/scripts/init-premount/run_once.sh
exit
EOF
    printf "\n\n\n" | sudo update-initramfs -u
}
move_boot() {
    HAS_BOOT=$(grep -c "/boot" /etc/fstab)
    [[ $HAS_BOOT -eq 0 ]] || return 0
    sudo mount -o remount,ro /boot
    sudo cp -axT /boot /boot.tmp
    sudo umount /boot/efi && sudo umount /boot
    sudo rmdir /boot
    sudo mv -T /boot.tmp /boot
    sudo mount /boot/efi
    sudo sed "#/boot#d" -i /etc/fstab
    echo "GRUB_ENABLE_CRYPTODISK=y" | sudo tee --append /etc/default/grub
    sudo umount /boot
    sudo update-grub
    sudo grub-install "$DISK_PART"
    sudo rm -rf /boot.tmp
    sudo shutdown -r now
}
add_keyfile() {
    HAS_BOOT=$(grep -c "/boot" /etc/fstab)
    [[ $HAS_BOOT -gt 0 ]] && return 0
    HAS_KEYFILE=$(grep -c "/keyfile" /etc/crypttab)
    [[ $HAS_KEYFILE -gt 0 ]] && return 0
    sudo dd bs=512 count=4 if=/dev/random of=/keyfile iflag=fullblock
    sudo chmod 0600 /keyfile
    sudo cryptdetup luksAddKey "$LUKS_PART" /keyfile
    sudo cryptsetup luksDump "$LUKS_PART"
    sudo sed "s# luks,discard\$#/keyfile luks,discard,key-slot=1#g" /etc/crypttab
    echo 'KEYFILE_PATTERN="/keyfile"' | sudo tee --append /etc/cryptsetup-initramfs/conf-hook
    echo UMASK=0077 | sudo tee --append /etc/initramfs-tools/initramfs.conf
    sudo update-initramfs -u -k all
    stat -L -c "%A %n" /initrd.img

}
if [[ "$LUKS_VERSION" == "2" ]] ; then
    echo "Luks version is 2"
    create_initramfs_breakpoint
    create_initramfs_hook
else
    echo "$LUKS_VERSION"
    remove_initramfs_breakpoint
    move_boot
    add_keyfile
fi
