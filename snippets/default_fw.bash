#!/bin/bash

# Flush existing rules
sudo iptables -F
sudo iptables -X
sudo iptables -Z

# Set default policies
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD DROP


# Loopback traffic
sudo iptables -A INPUT -i lo -j ACCEPT

# === INPUT ===
sudo iptables -N DEFAULT_INPUT
sudo iptables -A INPUT -j DEFAULT_INPUT
sudo iptables -A DEFAULT_INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A DEFAULT_INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT
sudo iptables -A DEFAULT_INPUT -p udp --sport 67 --dport 68 -j ACCEPT
sudo iptables -A DEFAULT_INPUT -p icmp -j ACCEPT
sudo iptables -A DEFAULT_INPUT -m conntrack --ctstate INVALID -j LOG --log-prefix "IN-REJECT-INVALID: " --log-level 4
sudo iptables -A DEFAULT_INPUT -m conntrack --ctstate INVALID -j REJECT
sudo iptables -A DEFAULT_INPUT -j LOG --log-prefix "IN-REJECT-FINAL: " --log-level 4 -m limit --limit 5/min
sudo iptables -A DEFAULT_INPUT -j REJECT

# === OUTPUT ===
sudo iptables -N DEFAULT_OUTPUT
sudo iptables -A INPUT -j DEFAULT_OUTPUT
sudo iptables -A DEFAULT_OUTPUT -p udp --sport 68 --dport 67 -j ACCEPT
sudo iptables -A DEFAULT_OUTPUT -j LOG --log-prefix "OUT-ACCEPT-FINAL: " --log-level 4 -m limit --limit 5/min

# === FORWARD ===
sudo iptables -N DEFAULT_FORWARD
sudo iptables -A INPUT -j DEFAULT_FORWARD
sudo iptables -A DEFAULT_FORWARD -j LOG --log-prefix "FWD-REJECT-FINAL: " --log-level 4 -m limit --limit 5/min
sudo iptables -A DEFAULT_FORWARD -j REJECT
