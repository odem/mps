#!/bin/bash
cp -r /opt/umi/theme /boot/grub
grep "GRUB_GFXMODE=" /etc/default/grub >/dev/null 2>&1 && sed -i '/GRUB_GFXMODE=/d' /etc/default/grub
echo "GRUB_GFXMODE=\"1280x800x32\"" >> /etc/default/grub
grep "GRUB_THEME=" /etc/default/grub >/dev/null 2>&1 && sed -i '/GRUB_THEME=/d' /etc/default/grub
echo "GRUB_THEME=\"/boot/grub/theme/theme.txt\"" >> /etc/default/grub
update-grub
