# Makefile for build vhdl projects with yosys, nextpnr and icestorm
# Top module must be placed at root level, called <module_name.vhdl>
#
# Options
# 	TOP=<module_name> builds with new top module.

TOP := Switches_To_LEDs

BUILD_DIR := ./build

SRCS := ${wildcard src/*.vhdl}

# Location for build files
OUT := ${BUILD_DIR}/${TOP}

default: ${OUT}.bin
	
${OUT}.bin: ${OUT}.asc
	icepack $^ $@

${OUT}.asc: ${OUT}.json
	nextpnr-ice40 --hx8k --package cb132 --json $^ --pcf alchitry_cu2.pcf --sdc alchitry_cu2.sdc --asc $@

${OUT}.json: ${TOP}.vhdl
	mkdir -p ${dir $@}
	yosys -m ghdl -p 'ghdl $^ ${SRCS} -e ${basename $^}; synth_ice40 -json $@'

.PHONY: prog
prog: ${OUT}.bin
	openFPGALoader --verify -b ice40_generic ${OUT}.bin

.PHONY: clean
clean:
	rm -r build/
	rm -f *.json
	rm -f *.asc
	rm -f *.bin

.DELETE_ON_ERROR:
