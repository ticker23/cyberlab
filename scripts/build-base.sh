#!/bin/bash
 #NOTE:using set -e is for error if occure so the code can break but it skips if, or,and

set -e 
PKG="wget,curl,iproute2,sudo,openssh-server,neovim,tmux,tcpdump,qemu-guest-agent"


if [ "$(hostname)" != "zaharklab" ]; then
	echo "deploy from the server"
	exit 1;
fi

list=(virt-customize virt-builder virt-sysprep)
lack=()

for pkg in "${list[@]}"; do

	if ! command -v "$pkg" >/dev/null 2>&1; then 
		lack+=("$pkg")
		echo "brakuje paczki z: $pkg"
	fi

	echo $?
done 

echo "counter: ${#list[@]}"

[[ -d "/var/lib/libvirt/images" ]] && echo "directory images exist" || { echo "ERROR directory images doesnt exist"; exit 1; }

export LIBGUESTFS_DEBUG=1 LIBGUESTFS_TRACE=1 
export LIBGUESTFS_BACKEND_SETTINGS="network_dns=1.1.1.1"

virt-builder debian-12 \
	--size 12G \
	--format qcow2 \
	--root-password password:root \
	--hostname test \
	--run-command 'useradd -m -s /bin/bash test' \
	--run-command 'usermod -aG sudo test' \
	--run-command 'systemctl enable qemu-guest-agent.service serial-getty@ttyS0.service' \
	--output /opt/cyberlab/cache/debian-base.qcow2

