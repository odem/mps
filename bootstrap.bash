#!/bin/bash
# --- Read opt ----------------------------------------------------------------
MPS_USER=mps
MPS_PASS=mps
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

