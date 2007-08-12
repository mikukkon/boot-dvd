USER 	  = mikukkon
DL_DIR	  = iso
ROOT_DIR  = dvd_root
ISO_LIST  = iso.list
ISO_FILE  = dvd_boot.iso

SRC_FILES = iso.list make_boot_dvd Makefile menu.xpm.gz
DOC_FILES = CREDITS FAQ README

default:
	-@ echo "Helpful make targets:"
	-@ echo "\tmake download => Just download the ISO-files"
	-@ echo "\tmake unpack   => Just unpack the ISO-files"
	-@ echo "\tmake burn     => Just burn the ISO-image"
	-@ echo ""
	-@ ./make_boot_dvd -h

download:
	./make_boot_dvd -b -u -v

unpack:
	sudo ./make_boot_dvd -b -n -c $(USER) -v

burn:
	./make_boot_dvd -n -u -v

shipit: $(ROOT_DIR)
	rm -rf $(ROOT_DIR)/src
	mkdir $(ROOT_DIR)/src
	cp $(SRC_FILES) $(DOC_FILES) $(ROOT_DIR)/src

$(ISO_FILE): $(ISO_LIST)
	sudo ./make_boot_dvd -c $(USER)

qemu: $(ISO_FILE)
	qemu -cdrom $(ISO_FILE) -boot d -m 512

gitignore:
	echo .gitignore > .gitignore
	echo $(DL_DIR) >> .gitignore
	echo $(ROOT_DIR) >> .gitignore
	echo $(ISO_FILE) >> .gitignore
	echo '*~' >> .gitignore
