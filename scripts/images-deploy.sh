#!/bin/bash
source /opt/cyberlab/config.env

set -euo pipefail

VMs=("client-a" "server" "router")

for vm in "${VMs[@]}"; do
	if [[ -f "${vm}.qcow2" ]]; then #if file exist
		echo "file exist $vm"
		continue
	fi

	IMAGE="/var/lib/libvirt/images/cyberlab/instances/"${vm}.qcow2""
	GOLDEN="/opt/cyberlab/cache/debian-base.qcow2"

		 qemu-img create \
			-f qcow2 \
			-F qcow2 \
			-b "$GOLDEN" \
			"$IMAGE"
		echo "Deployed image $vm "

		virt-customize -v -x \
			--format qcow2 \
			-a "$IMAGE" \
			--hostname "$vm" \
			--run-command "rm -f /etc/ssh/ssh_host_*" \
			--run-command "ssh-keygen -A"
		#	--firstboot "$DIR_LAB/scripts/${vm}.sh" \


done



