#!/bin/bash

# This script is based on https://unix.stackexchange.com/revisions/480191/9.

# Recommended SIZE setting for different drives:
#   (SATA) SSD: 1024 (default)
#   (ANY) HDD: 256
#   (High End NVME) SSD: 4096
#   (Low-Mid End NVME) SSD: 1024 (default)

command -v fio >/dev/null 2>&1 || { echo >&2 "Package 'fio' not installed. Aborting."; exit 1; }
command -v jq >/dev/null 2>&1 || { echo >&2 "Package 'jq' not installed. Aborting."; exit 1; }

LOOPS=5 # How many times to run each test
SIZE=256 # Size of each test, multiples of 32 recommended for Q32 tests to give the most accurate results.
WRITEZERO=0 # Set whether to write zeroes or randoms to testfile (random is the default for both fio and crystaldiskmark); dd benchmarks typically only write zeroes which is why there can be a speed difference.

QSIZE=$(($SIZE / 32)) # Size of Q32Seq tests
SIZE+=m
QSIZE+=m

if [ -z $1 ]; then
    TARGET=$HOME
    echo "Defaulting to $TARGET for testing"
else
    TARGET="$1"
    echo "Testing in $TARGET"
fi



echo "Configuration:
  Size = $SIZE
  Loops = $LOOPS
  Write Only Zeroes = $WRITEZERO
Running Benchmark, please wait...
"

fio --loops=$LOOPS --size=$SIZE --filename="$TARGET/.fiomark.tmp" --stonewall --ioengine=libaio --direct=1 --zero_buffers=$WRITEZERO --output-format=json --output "$TARGET/.fiomark.txt" \
  --name=Bufread --loops=1 --bs=$SIZE --iodepth=1 --numjobs=1 --rw=readwrite \
  --name=Seqread --bs=$SIZE --iodepth=1 --numjobs=1 --rw=read \
  --name=Seqwrite --bs=$SIZE --iodepth=1 --numjobs=1 --rw=write \
  --name=512kread --bs=512k --iodepth=1 --numjobs=1 --rw=read \
  --name=512kwrite --bs=512k --iodepth=1 --numjobs=1 --rw=write \
  --name=SeqQ32T1read --bs=$QSIZE --iodepth=32 --numjobs=1 --rw=read \
  --name=SeqQ32T1write --bs=$QSIZE --iodepth=32 --numjobs=1 --rw=write \
  --name=4kread --bs=4k --iodepth=1 --numjobs=1 --rw=randread \
  --name=4kwrite --bs=4k --iodepth=1 --numjobs=1 --rw=randwrite \
  --name=4kQ32T1read --bs=4k --iodepth=32 --numjobs=1 --rw=randread \
  --name=4kQ32T1write --bs=4k --iodepth=32 --numjobs=1 --rw=randwrite \
  --name=4kQ8T8read --bs=4k --iodepth=8 --numjobs=8 --rw=randread \
  --name=4kQ8T8write --bs=4k --iodepth=8 --numjobs=8 --rw=randwrite

QUERY='def read_bw(name): [.jobs[] | select(.jobname==name+"read").read.bw] | add / 1024 | floor;
       def read_iops(name): [.jobs[] | select(.jobname==name+"read").read.iops] | add | floor;
       def write_bw(name): [.jobs[] | select(.jobname==name+"write").write.bw] | add / 1024 | floor;
       def write_iops(name): [.jobs[] | select(.jobname==name+"write").write.iops] | add | floor;
       def job_summary(name): read_bw(name), read_iops(name), write_bw(name), write_iops(name);
       job_summary("Seq"), job_summary("512k"), job_summary("SeqQ32T1"),
       job_summary("4k"), job_summary("4kQ32T1"), job_summary("4kQ8T8")'
read -d '\n' -ra V <<< "$(jq "$QUERY" "$TARGET/.fiomark.txt")"

echo -e "
Results:  
\033[0;33m
Sequential Read: ${V[0]}MB/s IOPS=${V[1]}
Sequential Write: ${V[2]}MB/s IOPS=${V[3]}
\033[0;32m
512KB Read: ${V[4]}MB/s IOPS=${V[5]}
512KB Write: ${V[6]}MB/s IOPS=${V[7]}
\033[1;36m
Sequential Q32T1 Read: ${V[8]}MB/s IOPS=${V[9]}
Sequential Q32T1 Write: ${V[10]}MB/s IOPS=${V[11]}
\033[0;36m
4KB Read: ${V[12]}MB/s IOPS=${V[13]}
4KB Write: ${V[14]}MB/s IOPS=${V[15]}
\033[1;33m
4KB Q32T1 Read: ${V[16]}MB/s IOPS=${V[17]}
4KB Q32T1 Write: ${V[18]}MB/s IOPS=${V[19]}
\033[1;35m
4KB Q8T8 Read: ${V[20]}MB/s IOPS=${V[21]}
4KB Q8T8 Write: ${V[22]}MB/s IOPS=${V[23]}
"

echo -e "\033[0m" # Reset terminal colour.
rm "$TARGET/.fiomark.tmp"
