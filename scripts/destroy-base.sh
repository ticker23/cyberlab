#!/bin/bash
#cza rozbudować ten skrypt
source ../config.env

usage(){
echo "Options: -g -c -a -help"
echo "-g -gold | delete gold image"
echo "-c -clone | delete clone images"
echo "-a -all | deltete golden and clone images"
echo "-help | help"
echo "Example $0 -g -c -a -help"
}
golden_image=false
clone_images=false
 
while [[ $# -gt 0 ]]; do
	case $1 in 
		"-g" | "-gold")
		golden_image=true
			shift
			;;
		"-c" | "-clone")
			
			clone_images=true
			shift
			;;
		"-a | -all")
			golden_image=true
			clone_images=true
			shift 
			;;
		"-help")
			usage()
			shift
			;;
	esac

	if [[ $golden_image == true ]]; then
			ssh lab "rm -f /opt/cyberlab/cyberlab/debian-base.qcow2"

	elif [[ $golden_image == true ]]; then
			ssh lab "rm -f /var/lib/libvirt/images/cyberlab/instances/*.qcow2"

	elif [[ $golden_image == true && $clone_images == true ]]; then
			ssh lab "rm -f /opt/cyberlab/cyberlab/debian-base.qcow2 && rm -f /var/lib/libvirt/images/cyberlab/instances/*.qcow2"
	fi



		
if [[ $golden_image == false && $clone_images == false ]]; then
	usage()
fi
