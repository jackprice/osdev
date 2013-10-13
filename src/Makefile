all: ../test/disk.img build
	-../build/mount-disk.sh

../test/disk.img: build
	../build/build.sh

build: ../build/bootsector.bin
	make -C ../test disk

../build/bootsector.bin: bootsector.asm
	fasm bootsector.asm 
	cp bootsector.bin ../build/

bootsector.asm: bootstrap.asm
	echo "Generating bootsector..."
	./make-bootsector.sh > bootsector.asm

clean:
	-rm -f bootsector.bin
