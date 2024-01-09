#!/bin/sh

# -- NURODEV -----------------------------------------------------------------
WEBDIR=/home/design-daas/backend/web
# Directories
alias dir-web="z $WEBDIR"
# Service control
alias srv-demo="z $WEBDIR ; make demo"
alias srv-serve="z $WEBDIR ; make serve"
# Other
alias vq="z $WEBDIR ; nvim daas_web/quart_app.py"
alias backend="z ~/mps/repo/github/nuromedia/design-daas/backend"
alias nuro=" z ~/mps/repo/github/nuromedia"
alias nuromux="tmuxinator stop nuro ; tmuxinator start nuro"

