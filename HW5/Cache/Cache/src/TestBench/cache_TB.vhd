library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity cache_tb is
end cache_tb;

architecture TB_ARCHITECTURE of cache_tb is
	-- Component declaration of the tested unit
	component cache
	port(
		CLK : in STD_LOGIC;
		WRITE_ENABLE0 : in STD_LOGIC;
		WRITE_ENABLE1 : in STD_LOGIC;
		ADDR : in STD_LOGIC_VECTOR(31 downto 0);
		WRITE_DATA : in STD_LOGIC_VECTOR(31 downto 0);
		DATA : out STD_LOGIC_VECTOR(31 downto 0);
		HIT : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC;
	signal WRITE_ENABLE0 : STD_LOGIC;
	signal WRITE_ENABLE1 : STD_LOGIC;
	signal ADDR : STD_LOGIC_VECTOR(31 downto 0);
	signal WRITE_DATA : STD_LOGIC_VECTOR(31 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal DATA : STD_LOGIC_VECTOR(31 downto 0);
	signal HIT : STD_LOGIC;
	constant CLK_PERIOD : time := 10 ns;
	constant WAIT_TIME : time := 200ns;
	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : cache
		port map (
			CLK => CLK,
			WRITE_ENABLE0 => WRITE_ENABLE0,
			WRITE_ENABLE1 => WRITE_ENABLE1,
			ADDR => ADDR,
			WRITE_DATA => WRITE_DATA,
			DATA => DATA,
			HIT => HIT
		);

	-- Add your stimulus here ...
	CLK_PROC :process
	begin
	    CLK <= '1';
	    wait for CLK_PERIOD/2;
	    CLK <= '0';
	    wait for CLK_PERIOD/2;
	end process;

	STM: process
	begin

	    ADDR <= "01110100110010111111011000100100";
	    WRITE_DATA <= "00001101111111101101010101111100";
	    WRITE_ENABLE0 <= '1';
	    WRITE_ENABLE1 <= '0';
	    wait for WAIT_TIME;

	    ADDR <= "00011111000000011110000010101100";
	    WRITE_DATA <= "00011110001101100101010110011000";
	    WRITE_ENABLE0 <= '0';
	    WRITE_ENABLE1 <= '1';
	    wait for WAIT_TIME;

	    ADDR <= "01110100110010111111011000100100";
	    WRITE_ENABLE0 <= '0';
	    WRITE_ENABLE1 <= '0';
	    wait for WAIT_TIME;

	    ADDR <= "10100111000010000001011001110010";
	    WRITE_ENABLE0 <= '0';
	    WRITE_ENABLE1 <= '0';
	    wait for WAIT_TIME;

	    ADDR <= "00011111000000011110000010101100";
	    WRITE_ENABLE0 <= '0';
	    WRITE_ENABLE1 <= '0';
	    wait for WAIT_TIME;

	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_cache of cache_tb is
	for TB_ARCHITECTURE
		for UUT : cache
			use entity work.cache(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_cache;
