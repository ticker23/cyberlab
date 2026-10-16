#!/bin/bash

set -euo pipefail

IMAGES=("client-a" "server" "router")

for image in "${IMAGES[@]}"; do
	IMAGE="/var/lib/libvirt/images/cyberlab/instances/"${image}.qcow2""
	if [[ ! -f  "$IMAGE" ]]; then
		echo "$image doesnt exist"
		continue
	fi

	virt-install \
		--connect qemu:///system \
		--name "$image" \
		--memory 1028 \
		--disk path="$IMAGE" \
		--import \
		--network bridge=br-lab \
		--vcpus 1 \
		--osinfo debian12 \
		--noautoconsole
		
	done		
