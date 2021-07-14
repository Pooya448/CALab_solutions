SetActiveLib -work
comp -include "$dsn\src\ram.vhd" 
comp -include "$dsn\src\TestBench\ram_TB.vhd" 
asim +access +r TESTBENCH_FOR_ram 
wave 
wave -noreg CLK
wave -noreg ENABLE
wave -noreg DATA_IN
wave -noreg ADDR_IN0
wave -noreg ADDR_IN1
wave -noreg PORT_EN0
wave -noreg PORT_EN1
wave -noreg DATA_OUT0
wave -noreg DATA_OUT1
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\ram_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_ram 
