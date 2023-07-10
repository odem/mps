#!/bin/bash
# --- Read opt ----------------------------------------------------------------
export DEBIAN_FRONTEND=noninteractive
USER=$(whoami)

# terminal
./installer/terminal-essentials.bash
./installer/terminal-homedir.bash
./installer/terminal-fonts.bash
./installer/terminal-vim.bash
./installer/terminal-nvim.bash

# desktop
./installer/desktop-essentials.bash
./installer/desktop-guitools.bash
./installer/desktop-rofi.bash
./installer/desktop-qtile.bash

