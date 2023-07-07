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
./installer/bootstrap-user.bash -u "$MPS_USER" -p "$MPS_PASS"

sudo -u "$MPS_USER" ./installer/bootstrap-homedir.bash
sudo -u "root" ./installer/bootstrap-homedir.bash -a configure
