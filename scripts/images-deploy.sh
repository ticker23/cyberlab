#!/bin/bash
source /opt/cyberlab/config.env

set -euo pipefail

VMs=("client-a" "server" "router")

for vm in "${VMs[@]}"; do
	if [[ -f "$vm" ]]; then #if file exist
		echo "file exist $vm"
		continue
	fi

	IMAGE="/var/lib/libvirt/images/cyberlab/instances/"${vm}.qcow2""

		qemu-img create \
			-f qcow2 \
			-F qcow2 \
			-b "$DIR_LAB"/cache/debian-base.qcow2 \
			"$IMAGE"
		echo "Deployed image $vm "

		virt-customize \
			-a "$IMAGE" \
			--format qcow2 \
			--hostname "$vm" \
			--run-command "rm -f /etc/ssh/ssh_host*" \
			--firstboot "$DIR_LAB/scripts/${vm}.sh" \
			--firstboot "ssh-keygen -A"

		echo "Executed ${vm}.sh"

done



