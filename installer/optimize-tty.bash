#!/bin/bash
apt install -y kmscon
mkdir /etc/kmscon
cat <<EOF > /etc/kmscon/kmscon.conf
font-size=14
xkb-repeat-delay=100
xkb-repeat-rate=100
EOF
kmscon &


