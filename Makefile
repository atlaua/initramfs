# include all files listed in list.in here
extra_files = lvm.conf
progs       = /bin/busybox /sbin/cryptsetup /sbin/lvm


# list is a phony target because it depends on external data (libraries)
.PHONY: all clean list install

all: initramfs.img

clean:
	rm -f initramfs.img init list

install:
	cp --backup=simple --suffix=.old initramfs.img /boot/

initramfs.img: init list $(extra_files)
	scripts/gen_initramfs_list.sh -o initramfs.img list

init: init.in vars
	./gen_init

list: list.in
	cp list.in list
	lddtree --list -- $(progs) | sort -u | sed -e 's:^\(/usr\)\?\(.*\)$$:file \2\t\0\t755 0 0:' >> list
