# First ever makefile for VHDL building.
# Check makefiletutorial.com for a refresher 

# .DELETE_ON_ERROR:

TOP := Switches_To_LEDs

BUILD_DIR := ./build

# Location for build files
OUT := ${BUILD_DIR}/${TOP}

default: ${OUT}.bin
	
${OUT}.bin: ${OUT}.asc
	icepack $^ $@

${OUT}.asc: ${OUT}.json
	nextpnr-ice40 --hx8k --package cb132 --json $^ --pcf alchitry_cu2.pcf --sdc alchitry_cu2.sdc --asc $@

${OUT}.json: ${TOP}.vhdl
	mkdir -p ${dir $@}
	yosys -m ghdl -p 'ghdl $^ -e ${basename $^}; synth_ice40 -json $@'

.PHONY: prog
prog: ${OUT}.bin
	openFPGALoader --verify -b ice40_generic ${OUT}.bin

.PHONY: clean
clean:
	rm -r build/
	rm -f *.json
	rm -f *.asc
	rm -f *.bin
