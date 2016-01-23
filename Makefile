# include all files listed in list.in here
extra_files := lvm.conf


.PHONY: all clean

all: initramfs.img

clean:
	rm -f initramfs.img init

initramfs.img: init list $(extra_files)
	scripts/gen_initramfs_list.sh -o initramfs.img list

init: init.in vars
	./gen_init
