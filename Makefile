all:
	make -C src all

test: all
	make -C test run

clean:
	make -C src clean
	make -C test clean
	cd build; rm -f mount/*; rm -f bootsector.bin
