#!/bin/bash
export SUDO_ASKPASS=/usr/bin/ssh-askpass
sudo -A apt update -y && sudo -A upgrade
