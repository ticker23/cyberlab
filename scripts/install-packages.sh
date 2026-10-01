#!/bin/bash
source /opt/cyberlab/config.env

set -eu
#packages required for all machines
PKG="wget,curl,iproute2,sudo,openssh-server,neovim,tmux,tcpdump,qemu-guest-agent"

if [[ -f "${LAB_DIR}/cache/debian-base.qcow2" ]]; then 
	echo "[OK] image exist"
else
	echo "[ERROR] image doesnt exist"
	exit 1;
fi

exec /usr/bin/virt-customize -v -x\
	--format qcow2 \
	-a "${LAB_DIR}/cache/debian-base.qcow2" \
	--install "${PKG}" \
	--ssh-inject test:file:/home/zahark/.ssh/id_ed25519_lab.pub



