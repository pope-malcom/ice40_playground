# First ever makefile for VHDL building.
# Check makefiletutorial.com for a refresher 
.DELETE_ON_ERROR:

TOP := Switches_To_LEDs

${TOP}.bin: ${TOP}.asc
	icepack Switches_To_LEDs.asc Switches_To_LEDs.bin

${TOP}.asc: ${TOP}.json
	nextpnr-ice40 --hx8k --package cb132 --json ${TOP}.json --pcf alchitry_cu2.pcf --sdc alchitry_cu2.sdc --asc ${TOP}.asc

${TOP}.json: ${TOP}.vhdl
	yosys -m ghdl -p 'ghdl ${TOP}.vhdl -e ${TOP}; synth_ice40 -json ${TOP}.json'

.PHONY: prog
prog: ${TOP}.bin
	openFPGALoader --verify -b ice40_generic ${TOP}.bin

.PHONY: clean
clean:
	rm -f *.json
	rm -f *.asc
	rm -f *.bin
