LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

	-- Add your library and packages declaration here ...

entity ram_tb is
end ram_tb;

architecture TB_ARCHITECTURE of ram_tb is
	-- Component declaration of the tested unit
	component ram
	port(
		CLK : in STD_LOGIC;
		ENABLE : in STD_LOGIC;
		DATA_IN : in STD_LOGIC_VECTOR(31 downto 0);
		ADDR_IN0 : in STD_LOGIC_VECTOR(9 downto 0);
		ADDR_IN1 : in STD_LOGIC_VECTOR(9 downto 0);
		PORT_EN0 : in STD_LOGIC;
		PORT_EN1 : in STD_LOGIC;
		DATA_OUT0 : out STD_LOGIC_VECTOR(31 downto 0);
		DATA_OUT1 : out STD_LOGIC_VECTOR(31 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC;
	signal ENABLE : STD_LOGIC;
	signal DATA_IN : STD_LOGIC_VECTOR(31 downto 0);
	signal ADDR_IN0 : STD_LOGIC_VECTOR(9 downto 0);
	signal ADDR_IN1 : STD_LOGIC_VECTOR(9 downto 0);
	signal PORT_EN0 : STD_LOGIC;
	signal PORT_EN1 : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal DATA_OUT0 : STD_LOGIC_VECTOR(31 downto 0);
	signal DATA_OUT1 : STD_LOGIC_VECTOR(31 downto 0);
	
	constant period : time := 10 ns;
	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : ram
		port map (
			CLK => CLK,
			ENABLE => ENABLE,
			DATA_IN => DATA_IN,
			ADDR_IN0 => ADDR_IN0,
			ADDR_IN1 => ADDR_IN1,
			PORT_EN0 => PORT_EN0,
			PORT_EN1 => PORT_EN1,
			DATA_OUT0 => DATA_OUT0,
			DATA_OUT1 => DATA_OUT1
		);
		
		CLK_PROC :process
   begin
        CLK <= '1';
        wait for period / 2;
        CLK <= '0';
        wait for period / 2;
   end process;	   
   
   STM: process
   begin

        PORT_EN0 <= '0';
        ENABLE <= '1';
        DATA_IN <= X"FFFFFFFF";
        ADDR_IN0 <= b"0000000001";
        wait for 20 ns;

        PORT_EN0 <= '1';
      for i in 1 to 16 loop
            DATA_IN <= conv_std_logic_vector(i, 32);
            ADDR_IN0 <= conv_std_logic_vector(i - 1, 10);
            wait for 10 ns;
        end loop;

        ENABLE <= '0';
        PORT_EN0 <= '0';

        PORT_EN1 <= '1';
        for i in 1 to 16 loop
            ADDR_IN1 <= conv_std_logic_vector(i - 1, 10);
            wait for 10 ns;
        end loop;
		
        PORT_EN1 <= '0';

      wait;
   end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_ram of ram_tb is
	for TB_ARCHITECTURE
		for UUT : ram
			use entity work.ram(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_ram;

