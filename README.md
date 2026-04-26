# VHDL_Dump
Basic VHDL stuff for fun and to stay sharp 

## Tools
Using GHDL and GTKWave within WSL

## Vague workflow so I dont forget
### Analysis 
`ghdl -a design_file.vhd` 

`ghdl -a testbench.vhd`
### Elaboration
`ghdl -e testbench`
### Run
`ghdl -r testbench --wave=wave.ghw`
### Graphical waveform view
`gtkwave wave.ghw`
