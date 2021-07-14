SetActiveLib -work
comp -include "$dsn\src\reg_file.vhd" 
comp -include "$dsn\src\TestBench\register_file_TB.vhd" 
asim +access +r TESTBENCH_FOR_register_file 
wave 
wave -noreg CLK
wave -noreg RST
wave -noreg RegWrite
wave -noreg WriteReg
wave -noreg Data
wave -noreg readreg1
wave -noreg read1
wave -noreg readreg2
wave -noreg read2
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\register_file_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_register_file 
