.PHONY: clean all

all: rootfs

clean:
	sudo rm -rf rootfs

cache:
	mkdir -p cache

cache/alarm.tar.gz: cache
	curl -Lo cache/alarm.tar.gz https://ftp.halifax.rwth-aachen.de/archlinux-arm/os/ArchLinuxARM-armv7-latest.tar.gz

rootfs: cache/alarm.tar.gz
	sudo mkdir -p rootfs/steamlink/factory_test
	sudo cp scripts/init-trampoline rootfs/
	sudo cp scripts/handoff rootfs/
	sudo cp metadata/factory_test rootfs/steamlink/factory_test/run.sh
	sudo bsdtar -xpf cache/alarm.tar.gz -C rootfs
