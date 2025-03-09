# ------------------------------------------------------------------------------
# --- Defaults
# ------------------------------------------------------------------------------
# Makefiel setup
.PHONY: default build start stop connect clean
default: start
# Shell setup
SHELL:=/bin/bash
# Vars
IMGNAME?=skeleton
CONTNAME?=$(IMGNAME)
LPORT?=4444
RPORT?=4444
# ------------------------------------------------------------------------------
# --- Help
# ------------------------------------------------------------------------------
usage:
	@echo "make TARGET"
	@echo "   TARGETS: "
	@echo "     usage: Help message"
	@echo ""
	@echo "     build: Build container"
	@echo "     start: Start container"
	@echo "     stop : Stop container"
	@echo "     clean: Clean conatiner and images"
	@echo ""
# ------------------------------------------------------------------------------
# --- Default targets
# ------------------------------------------------------------------------------
build: stop
	-mkdir -p app/keys
	[[ -f app/keys/cert.pem ]] || \
		openssl req -x509 -newkey rsa:4096 -days 365 -nodes \
		-out app/keys/cert.pem -keyout app/keys/key.pem \
		-subj "/C=DE/ST=Berlin/L=Berlin/O=org/OU=unit/CN=localhost"
	docker build -t $(IMGNAME) . 
start: build
	docker run \
		-p $(LPORT):$(RPORT) \
		-v `pwd`/app:/opt/quart/skeleton/app \
		-d --rm --name $(CONTNAME) $(IMGNAME)
stop:
	-docker kill $(CONTNAME)
connect:
	docker exec -it $(CONTNAME) bash
clean: stop
	-docker rm $(CONTNAME)
	-docker image rm $(IMGNAME)

