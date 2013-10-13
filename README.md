# osdev

OS Development toolset to allow teaching the basics, whilst speeding up 
development by taking things like creating boot disks off your chest.

Created by [Quetuo](mailto:quetuo@quetuo.net)

## Quick start
```
git clone https://github.com/Quetuo/osdev.git
cd osdev
sudo make test
```
If everything's gone to plan, you'll see a Bochs window open up with a Hello 
World message.

### What's included
Within the repository you'll find the following key directories and files
```
osdev/
--src/
----bootstrap.asm
--test/
----config.sh
--build/
```
`src/bootstrap.asm` contains our Hello World. The code in here is compiled and 
automatically slotted into the MBR (Master Boot Record) of the virtual disk 
created. That way, you only have to worry about the actual code, not 
formatting your disks.

## To be continued...
