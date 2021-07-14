library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity full_adder_8_bit_tb is
end full_adder_8_bit_tb;

architecture TB_ARCHITECTURE of full_adder_8_bit_tb is
	-- Component declaration of the tested unit
	component full_adder_8_bit
	port(
		A : in STD_LOGIC_VECTOR(7 downto 0);
		B : in STD_LOGIC_VECTOR(7 downto 0);
		cin : in STD_LOGIC;
		sum : out STD_LOGIC_VECTOR(7 downto 0);
		carry : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity 
	constant PERIOD: time := 50 ns;
	signal A : STD_LOGIC_VECTOR(7 downto 0);
	signal B : STD_LOGIC_VECTOR(7 downto 0);
	signal cin : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal sum : STD_LOGIC_VECTOR(7 downto 0);
	signal carry : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : full_adder_8_bit
		port map (
			A => A,
			B => B,
			cin => cin,
			sum => sum,
			carry => carry
		);

	-- Add your stimulus here ...
  STM: process

	begin

		wait for PERIOD;
		A <= "01100101";
		B <= "11111111";
		cin <= '0';

		wait for PERIOD;
		A <= "10101010";
		B <= "01001010";
		cin <= '0' ;

		wait for PERIOD;
		A <= "01111101";
		B <= "01011100";
		cin <= '0';

		wait for PERIOD;
		A <= "00001111";
		B <= "11110000";
		cin <= '0';

		wait for PERIOD;
		A <= "00100110";
		B <= "10011011";
		cin <= '0';

		wait for PERIOD;
		wait;
end process STM;


end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_full_adder_8_bit of full_adder_8_bit_tb is
	for TB_ARCHITECTURE
		for UUT : full_adder_8_bit
			use entity work.full_adder_8_bit(full_adder_8_arch);
		end for;
	end for;
end TESTBENCH_FOR_full_adder_8_bit;
