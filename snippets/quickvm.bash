#!/bin/bash

VMNAME="none"
ACTION="none"
CLONEFROM="none"
ISOFILE="$HOME/mps/iso/Win11_22H2_German_x64v2.iso"
QUICKFOLDER=~/mps/vm/quick
SSHUSER="root"
SSHPORT=5556
TIMEOUTS=10
MEMSIZE=8192
CPUCOUNT=4
IMAGESIZE=64
# --- Read opt ----------------------------------------------------------------
while getopts "a:c:i:n:q:u:C:D:M:" o; do
    case "${o}" in
	a)
	    ACTION=${OPTARG}
	    ;;
	c)
	    CLONEFROM=${OPTARG}
	    ;;
        i)
            ISOFILE=${OPTARG}
            ;;
        n)
            VMNAME=${OPTARG}
            ;;
        q)
            QUICKFOLDER=${OPTARG}
	    QUICKFOLDER=$(realpath "$QUICKFOLDER")
            ;;
        u)
            SSHUSER=${OPTARG}
            ;;
        C)
            CPUCOUNT=${OPTARG}
            ;;
        D)
            IMAGESIZE=${OPTARG}
            ;;
        M)
            MEMSIZE=${OPTARG}
            ;;
        *)
            echo "Unknown option: '${OPTARG}'"
            echo "Aborting..."
            exit 2
            ;;
    esac
done
mkdir -p "$QUICKFOLDER"
cd "$QUICKFOLDER" || exit 1
SSHKEY="$QUICKFOLDER"/id_rsa_dummy
CLONEIMAGE="./$CLONEFROM".qcow2
IMAGENAME="./$VMNAME".qcow2
PIDFILE="./$VMNAME".pid
read -r -d '' RUNCMD << EOF
sudo kvm \
    -enable-kvm  \
    -machine q35,accel=kvm,usb=off,vmport=off,smm=on,dump-guest-core=off \
    -cpu host -smp $CPUCOUNT,sockets=1,cores=$CPUCOUNT,threads=1 -m $MEMSIZE \
    -rtc base=utc,driftfix=slew \
    -boot strict=on \
    -parallel none -serial none -k de \
    -device virtio-balloon \
    -device usb-ehci -device usb-tablet \
    -object iothread,id=io0 \
    -pidfile $PIDFILE \
    -netdev user,id=mynet0,hostfwd=tcp::$VMSSHPORT-:22 \
    -device virtio-net-pci,netdev=mynet0 \
    -object rng-random,id=rng0,filename=/dev/urandom \
    -device virtio-rng-pci,rng=rng0 \
    -object iothread,id=io1 \
    -drive if=none,id=disk0,format=qcow2,cache-size=16M,cache=none,file=$IMAGENAME \
    -device virtio-blk-pci,drive=disk0,scsi=off,iothread=io1
EOF

# --- Actions ----------------------------------------------------------------
installvm() {
    # Test params
    [[ "$VMNAME" != "none" ]] || exit 2
    [[ -f "$ISOFILE" ]] || exit 3
    [[ ! -f "$IMAGENAME" ]] || exit 4
    # Create image and run
    qemu-img create -f qcow2 -o cluster_size=2M "$IMAGENAME" "$IMAGESIZE"G
    RUNCMD="$RUNCMD -cdrom $ISOFILE"
    $RUNCMD &
}
clonevm() {
    # Test params
    [[ "$VMNAME" != "none" ]] || exit 2
    [[ "$CLONEFROM" != "none" ]] || exit 3
    [[ -f "./$CLONEIMAGE" ]] || exit 4
    [[ ! -f "./$IMAGENAME" ]] || exit 5
    # Create image and run
    cp "$CLONEIMAGE" "$IMAGENAME"
}
deletevm() {
    # Test params
    [[ "$VMNAME" != "none" ]] || exit 6
    [[ -f "./$IMAGENAME" ]] || exit 7
    # Create image and run
    rm -rf "$IMAGENAME"
}
startvm() {
	$RUNCMD &
}
stopvm() {
    if [ -f "$PIDFILE" ] ; then
	sudo kill "$(sudo cat "$PIDFILE")"
	sudo rm -rf "$PIDFILE"
    fi
}
listvm() {
    for file in *.qcow2 ; do
	echo "${file%.*}"
    done
}
sshvm() {
    # Wait for host via ssh; exit if successfull
    for ((i = 0; i < "$TIMEOUTS"; i++)); do
	ssh -i "$SSHKEY" \
	    -p "$SSHPORT" \
	    -o StrictHostKeyChecking=no \
	    -o BatchMode=yes \
	    -o ConnectTimeout=1 \
	    "${SSHUSER}"@localhost
	RET=$?
	if [[ $RET -eq 0 ]] ; then
	    break
	else
	    sleep 3
	fi
    done
}
# --- Chose Action ----------------------------------------------------------------
case "${ACTION}" in
    install)
	installvm
	;;
    clone)
	clonevm
	;;
    delete)
	deletevm
	;;
    start)
	startvm
	;;
    stop)
	stopvm
	;;
    ssh)
	sshvm
	;;
    list)
	listvm
	;;
    *)
	echo "Unknown action: '${ACTION}'"
	echo "Aborting..."
	exit 2
	;;
esac

