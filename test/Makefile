all: bochsrc

bochsrc: config.sh
	./make-bochsrc.sh > bochsrc

run: bochsrc disk
	make -C ../src build
	./run.sh

disk: 
	./make-disk.sh

remake: 
	touch config.sh
	make all

clean:
	../build/unmount-disk.sh
	-rm -f disk.img
	rm -f bochsrc
