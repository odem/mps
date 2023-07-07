#!/bin/bash
# --- Read opt ----------------------------------------------------------------
MPS_USER=dummy
MPS_PASS=dummy
while (( "$#" )); do
    case "$1" in
        "-u")
            MPS_USER=$2
            shift 2
            ;;
        "-p")
            MPS_PASS=$2
            shift 2
            ;;
        *)
            echo "Unknown option: '${OPTARG}'"
            echo "Aborting..."
            exit 1
            ;;
    esac
done

# Bootstrap
./installer/bootstrap-user.bash -u "$MPS_USER" -p "$MPS_PASS"
sudo -u "$MPS_USER" ./installer/bootstrap-homedir.bash
sudo -u "root" ./installer/bootstrap-homedir.bash -a configure

# terminal
sudo -u "$MPS_USER" ./installer/terminal-essentials.bash
sudo -u "$MPS_USER" ./installer/terminal-fonts.bash
sudo -u "$MPS_USER" ./installer/terminal-vim.bash
sudo -u "$MPS_USER" ./installer/terminal-nvim.bash

# terminal config as root as well
sudo -u "root" ./installer/terminal-essentials.bash -a configure
sudo -u "root" ./installer/terminal-fonts.bash -a configure
sudo -u "root" ./installer/terminal-vim.bash -a configure
sudo -u "root" ./installer/terminal-nvim.bash -a configure

# desktop
sudo -u "$MPS_USER" ./installer/desktop-essentials.bash
sudo -u "$MPS_USER" ./installer/desktop-guitools.bash
sudo -u "$MPS_USER" ./installer/desktop-rofi.bash
sudo -u "$MPS_USER" ./installer/desktop-qtile.bash

