# Default targets
.PHONY: default start stop clean
default: usage

# Makefile setup
SHELL:=/bin/bash

# Help
usage:
	@echo "make TARGET"
	@echo "   TARGETS: "
	@echo "     usage: Help message"
	@echo ""

# Targets
start:
	echo "Start"
stop:
	echo "Stop"
clean:
	echo "Clean"
