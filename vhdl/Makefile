
.PHONY: all
all: test 

# no need to call this target, it's only here FYI
#.PHONY: convert
#convert:
#	./pla_jed2vhdl.py C64APLA.jed.txt c64pla_core_2.vhd c64pla_core

.PHONY: test
test:
	echo
	echo ### executing testbench with GHDL ###
	echo
	./pla_bin2txt.py > c64pla_tb.txt
	ghdl -a c64pla.vhd
	ghdl -a c64pla_core.vhd
	ghdl -a c64pla_tb.vhd
	ghdl -e c64pla_tb
	ghdl -r c64pla_tb --vcd=test.vcd

.PHONY: isetest
isetest:
	echo
	echo ### executing testbench with  Xilinx isim ###
	echo
	./pla_bin2txt.py > c64pla_tb.txt
	fuse work.c64pla_tb -prj testbench.prj -o c64pla_tb
	echo "run all" | ./c64pla_tb

.PHONY: clean
clean:
	rm -f c64pla_tb.txt
	rm -f c64pla_tb
	rm -f *.o
	rm -f work-obj93.cf
	rm -f test.vcd
	rm -rf isim
	rm -f isim.log
	rm -f isim.wdb
	rm -f fuse.log
	rm -f fuseRelaunch.cmd
	rm -f fuse.xmsgs
