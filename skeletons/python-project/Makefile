# Default targets
.PHONY: default usage build start stop clean
default: usage

# Makefile setup
SHELL:=/bin/bash

PROJECT_NAME:=unattend_my_iso
PROJECT_AUTHOR:=jb
PROJECT_EMAIL:=foo@bar.baz
PROJECT_VERSION:=0.0.1
DIR_VENV?=.venv
# Help
usage:
	@echo "make TARGET"
	@echo "   TARGETS: "
	@echo ""
	@echo "     clean  : Cleans tempfiles"
	@echo "     build  : Help message"
	@echo "     install: Install tool"
	@echo ""
	@echo "     start  : Starts tool"
	@echo "     stop   : Stops tool"
	@echo ""
	@echo "     usage  : Help message"
	@echo ""

# Targets
$(DIR_VENV):
	if [[ ! -d $(DIR_VENV) ]]; then \
		python3 -m venv $(DIR_VENV) ; \
	fi
update_dummies:
	@find . -type f \( -name "*.md" -o -name "*.py" -o -name "*.toml" -o -name "*.cfg" -o -name "*.in" \) \
		-exec sed -i "s/DUMMY_NAME/$(PROJECT_NAME)/g" {} +
	@find . -type f \( -name "*.md" -o -name "*.py" -o -name "*.toml" -o -name "*.cfg" -o -name "*.in" \) \
		-exec sed -i "s/DUMMY_AUTHOR/$(PROJECT_AUTHOR)/g" {} +
	@find . -type f \( -name "*.md" -o -name "*.py" -o -name "*.toml" -o -name "*.cfg" -o -name "*.in" \) \
		-exec sed -i "s/DUMMY_EMAIL/$(PROJECT_EMAIL)/g" {} +
	@find . -type f \( -name "*.md" -o -name "*.py" -o -name "*.toml" -o -name "*.cfg" -o -name "*.in" \) \
		-exec sed -i "s/DUMMY_VERSION/$(PROJECT_VERSION)/g" {} +
build: | update_dummies $(DIR_VENV)
	source $(DIR_VENV)/bin/activate && \
		pip install --upgrade build && \
		python -m build
install: build
	source $(DIR_VENV)/bin/activate ; \
		pip install --editable .
debugstart: 
	source $(DIR_VENV)/bin/activate ; \
		python3 -m src.$(PROJECT_NAME).main

fullstart: build
	source $(DIR_VENV)/bin/activate ; \
		$(PROJECT_NAME)
stop:
	echo "Stop"
clean:
	rm -rf build dist src/$(PROJECT_NAME).egg-info
