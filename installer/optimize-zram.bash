#!/bin/bash
sudo apt install zram-tools
echo -e "ALGO=zstd\nPERCENT=30" | sudo tee -a /etc/default/zramswap
sudo service zramswap reload

