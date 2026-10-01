include config.env
export

.PHONY: deploy-base rmbase update install

deploy-base:
	ssh lab "cd /opt/cyberlab/scripts && bash build-base.sh 2>&1 | tee build.log" 

rmbase:
	ssh zahark@100.84.29.65 "sudo rm -f /var/lib/libvirt/images/debian-base.qcow2"

update:
	rsync -avz ~/Projects/CyberLab/ --exclude Makefile --exclude .git/ zahark@100.84.29.65:/opt/cyberlab

install:
	ssh lab "export LIBGUESTFS_DEBUG=1 LIBGUESTFS_TRACE=1 && ${LAB_DIR}/scripts/install-packages.sh" > debug.txt 2>&1; echo "SCRIPT [DONE]"

