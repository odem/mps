#!/bin/bash
# --- Read opt ----------------------------------------------------------------
MPS_USER=mps
while (( "$#" )); do
    case "$1" in
        "-u")
            MPS_USER=$2
            shift 2
            ;;
        *)
            echo "Unknown option: '${OPTARG}'"
            echo "Aborting..."
            exit 1
            ;;
    esac
done
# terminal
sudo -u "$MPS_USER" ./installer/terminal-essentials.bash
sudo -u "$MPS_USER" ./installer/terminal-homedir.bash
sudo -u "$MPS_USER" ./installer/terminal-fonts.bash
sudo -u "$MPS_USER" ./installer/terminal-vim.bash
sudo -u "$MPS_USER" ./installer/terminal-nvim.bash

# terminal config as root as well
sudo -u "root" ./installer/terminal-essentials.bash -a configure
sudo -u "root" ./installer/terminal-homedir.bash -a configure
sudo -u "root" ./installer/terminal-fonts.bash -a configure
sudo -u "root" ./installer/terminal-vim.bash -a configure
sudo -u "root" ./installer/terminal-nvim.bash -a configure

# Optimize
sudo -u "root" ./installer/optimize-tty.bash
sudo -u "root" ./installer/optimize-zram.bash
sudo -u "root" ./installer/optimize-grubmenu.bash
sudo -u "root" ./installer/optimize-lightdm.bash

