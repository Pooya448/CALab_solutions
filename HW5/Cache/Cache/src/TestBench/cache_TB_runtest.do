SetActiveLib -work
comp -include "$dsn\src\Cache.vhd" 
comp -include "$dsn\src\TestBench\cache_TB.vhd" 
asim +access +r TESTBENCH_FOR_cache 
wave 
wave -noreg CLK
wave -noreg WRITE_ENABLE0
wave -noreg WRITE_ENABLE1
wave -noreg ADDR
wave -noreg WRITE_DATA
wave -noreg DATA
wave -noreg HIT
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\cache_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_cache 
