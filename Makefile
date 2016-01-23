# include all files listed in list.in here
extra_files = lvm.conf
progs       = /bin/busybox /sbin/cryptsetup /sbin/lvm


# list is a phony target because it depends on external data (libraries)
.PHONY: all clean list

all: initramfs.img

clean:
	rm -f initramfs.img init list

initramfs.img: init list $(extra_files)
	scripts/gen_initramfs_list.sh -o initramfs.img list

init: init.in vars
	./gen_init

list: list.in
	cp list.in list
	lddtree --list -- $(progs) | sed -e 's:^\(/usr\)\?\(.*\)$$:file \2\t\0\t755 0 0:' >> list
