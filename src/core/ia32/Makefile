sources     = multiboot.s

#core : core.o
#	ld -s -Tcore.l -o core core.o
#	objcopy core -S -O binary
#
#core.o : $(sources)
#	as core.s -o core.o
#
clean :
	as boot.s -o boot.o
	as core.s -o core.o
	as root.s -o root.o
	as syslog.s -o syslog.o
	ld -s -Tboot.l -o boot boot.o
	ld -s -Tcore.l -o core core.o
	ld -s -Troot.l -o root root.o
	ld -s -Tsyslog.l -o syslog syslog.o
	objcopy boot -S -O binary
	objcopy core -S -O binary
	objcopy root -S -O binary
	objcopy syslog -S -O binary
	copy boot e:\core\boot
	copy core e:\core\core
	copy root e:\core\root
	copy syslog e:\core\syslog
