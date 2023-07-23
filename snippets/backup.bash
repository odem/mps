#!/bin/bash
#
BACKUP_DIR=/media/share/bigdata/smb-backup/borg/hive
cd "$BACKUP_DIR" || exit 1
# SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# cd "$SCRIPT_DIR" || exit 1

TAG=$(date '+%Y%m%d-%H%M%S')
#rm -rf backup
[[ ! -d backup ]] && mkdir backup && borg init --encryption=none backup

sudo borg create --progress --stats \
    backup::"${TAG}"-etc /etc

borg create --progress --stats \
    --exclude "sh:/home/*/.cache" \
    --exclude "sh:/home/*/.local/share" \
    --exclude "sh:/home/*/.local/state" \
    --exclude "sh:/home/*/.rustup" \
    --exclude "sh:/home/*/.cargo" \
    --exclude "sh:/home/*/.wine" \
    --exclude "sh:/home/*/.steam" \
    --exclude "sh:/home/*/Downloads" \
    --exclude "sh:/home/*/mps/" \
    backup::"${TAG}"-home /home

borg create --progress --stats \
    --exclude "sh:/home/*/mps/disks" \
    --exclude "sh:/home/*/mps/iso" \
    --exclude "sh:/home/*/mps/vm" \
backup::"${TAG}"-mps /home/jb/mps
