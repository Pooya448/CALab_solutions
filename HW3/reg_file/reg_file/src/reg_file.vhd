library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
------------------------------------
entity register_file is
port (
 CLK, RST: in std_logic;
 RegWrite: in std_logic;
 WriteReg: in std_logic_vector(4 downto 0);
 Data: in std_logic_vector(31 downto 0);

 readreg1: in std_logic_vector(4 downto 0);
 read1: out std_logic_vector(31 downto 0);

 readreg2: in std_logic_vector(4 downto 0);
 read2: out std_logic_vector(31 downto 0)
);
end register_file;

architecture Behavioral of register_file is
type reg_type is array (0 to 31) of std_logic_vector (31 downto 0);
signal reg_array: reg_type;
begin
 process(CLK,RST)
 begin
 if(RST='1') then
   reg_array(0) <= x"00000000";
   reg_array(1) <= x"00000000";
   reg_array(2) <= x"00000000";
   reg_array(3) <= x"00000000";
   reg_array(4) <= x"00000000";
   reg_array(5) <= x"00000000";
   reg_array(6) <= x"00000000";
   reg_array(7) <= x"00000000";
   reg_array(8) <= x"00000000";
   reg_array(9) <= x"00000000";
   reg_array(10) <= x"00000000";
   reg_array(11) <= x"00000000";
   reg_array(12) <= x"00000000";
   reg_array(13) <= x"00000000";
   reg_array(14) <= x"00000000";
   reg_array(15) <= x"00000000";
   reg_array(16) <= x"00000000";
   reg_array(17) <= x"00000000";
   reg_array(18) <= x"00000000";
   reg_array(19) <= x"00000000";
   reg_array(20) <= x"00000000";
   reg_array(21) <= x"00000000";
   reg_array(22) <= x"00000000";
   reg_array(23) <= x"00000000";
   reg_array(24) <= x"00000000";
   reg_array(25) <= x"00000000";
   reg_array(26) <= x"00000000";
   reg_array(27) <= x"00000000";
   reg_array(28) <= x"00000000";
   reg_array(29) <= x"00000000";
   reg_array(30) <= x"00000000";
   reg_array(31) <= x"00000000";

 elsif(rising_edge(CLK)) then
   if(RegWrite='1') then
    reg_array(to_integer(unsigned(WriteReg))) <= Data;
   end if;
 end if;
 end process;

 read1 <= x"00000000" when readreg1 = "00000" else reg_array(to_integer(unsigned(readreg1)));
 read2 <= x"00000000" when readreg2 = "00000" else reg_array(to_integer(unsigned(readreg2)));

end Behavioral;
