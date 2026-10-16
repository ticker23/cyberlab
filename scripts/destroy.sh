#!/bin/bash
#cza rozbudować ten skrypt

usage(){
echo "Options: -g -c -a -v -help"
echo "-g -gold | delete gold image"
echo "-c -clone | delete clone images"
echo "-a -all | deltete golden and clone images"
echo "-v -vm | vm-machine"
echo "-help | help"
echo "Example $0 -g -c -a -v -help"
}
golden_image=false
clone_images=false
vm-machine=false

if [[ $# -eq 0 ]]; then
	usage
	exit 1
fi
 
while [[ $# -gt 0 ]]; do
	case $1 in 
		-g | -gold)
		golden_image=true
			;;
		-c | -clone)
			
			clone_images=true
			;;
		-a | -all)
			golden_image=true
			clone_images=true
			;;
		-v | -vm)
			vm-machine=true
			;;
		-help)
			usage
			exit 1
			;;
		*)
			echo "Nieznana opcja $1"
			exit 1
			;;
	esac

	shift
done 

if [[ $golden_image == true ]]; then
		rm -f /opt/cyberlab/cyberlab/debian-base.qcow2

elif [[ $clone_images == true ]]; then
		rm -f /var/lib/libvirt/images/cyberlab/instances/*.qcow2

elif [[ $golden_image == true && $clone_images == true ]]; then
		rm -f /opt/cyberlab/cyberlab/debian-base.qcow2 && rm -f /var/lib/libvirt/images/cyberlab/instances/*.qcow2

elif [[ $vm-machine == true ]]; then
	virsh -c qemu:///system undefine * --remove-all-storage
	
fi



		
