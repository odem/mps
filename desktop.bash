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
        *)
            echo "Unknown option: '${OPTARG}'"
            echo "Aborting..."
            exit 1
            ;;
    esac
done

# desktop
sudo -u "$MPS_USER" ./installer/desktop-essentials.bash
sudo -u "$MPS_USER" ./installer/desktop-guitools.bash
sudo -u "$MPS_USER" ./installer/desktop-rofi.bash
sudo -u "$MPS_USER" ./installer/desktop-qtile.bash
#sudo -u "$MPS_USER" ./installer/desktop-extras.bash
