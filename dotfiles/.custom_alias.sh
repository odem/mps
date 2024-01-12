#!/bin/sh

# -- NURODEV -----------------------------------------------------------------
# Alias variables
# NOTE: Expand when defined, not when used!
# NOTE: Consider escaping
REPODIR=/home/jb/mps/repo/github/nuromedia/design-daas
BACKENDDIR=$REPODIR/backend
WEBDIR=$BACKENDDIR/web
NOWEBDIR=$BACKENDDIR/noweb
ISODIR=$BACKENDDIR/installer/iso
# Directories
alias dir-nuro="z $REPODIR"
alias dir-backend="z $BACKENDDIR"
alias dir-web="z $WEBDIR"
alias dir-noweb="z $NOWEBDIR"
alias dir-iso="z $ISODIR"
# Service control
alias srv-demo="z $WEBDIR ; make demo"
alias srv-serve="z $WEBDIR ; make serve"
# Other
alias vq="z $WEBDIR ; source .venv/bin/activate ; nvim daas_web/quart_app.py && deactivate && zz"
alias nuromux="tmuxinator stop nuro ; tmuxinator start nuro"

