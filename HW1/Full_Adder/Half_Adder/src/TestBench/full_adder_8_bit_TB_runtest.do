SetActiveLib -work
comp -include "$dsn\src\full_adder.vhd" 
comp -include "$dsn\src\TestBench\full_adder_8_bit_TB.vhd" 
asim +access +r TESTBENCH_FOR_full_adder_8_bit 
wave 
wave -noreg A
wave -noreg B
wave -noreg cin
wave -noreg sum
wave -noreg carry
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\full_adder_8_bit_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_full_adder_8_bit 
