library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity alu_tb is
	-- Generic declarations of the tested unit
		generic(
		SHIFT : NATURAL := 1 );
end alu_tb;

architecture TB_ARCHITECTURE of alu_tb is
	-- Component declaration of the tested unit
	component alu
		generic(
		SHIFT : NATURAL := 1 );
	port(
		IN1 : in STD_LOGIC_VECTOR(7 downto 0);
		IN2 : in STD_LOGIC_VECTOR(7 downto 0);
		ALU_SELECT : in STD_LOGIC_VECTOR(3 downto 0);
		ALU_OUTPUT : out STD_LOGIC_VECTOR(7 downto 0);
		CARRY_OUT : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal IN1 : STD_LOGIC_VECTOR(7 downto 0);
	signal IN2 : STD_LOGIC_VECTOR(7 downto 0);
	signal ALU_SELECT : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ALU_OUTPUT : STD_LOGIC_VECTOR(7 downto 0);
	signal CARRY_OUT : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alu
		generic map (
			SHIFT => SHIFT
		)

		port map (
			IN1 => IN1,
			IN2 => IN2,
			ALU_SELECT => ALU_SELECT,
			ALU_OUTPUT => ALU_OUTPUT,
			CARRY_OUT => CARRY_OUT
		);

	-- Add your stimulus here ... 
	-- Stimulus process
   -- Stimulus process
   STM: process
   begin

  IN1 <= "10101010";
  IN2 <=  "00100111";
  ALU_SELECT <= "1000";
  wait for 200 ns;
  ALU_SELECT <= "1001";
  wait for 200 ns;
  ALU_SELECT <= "1100";
  wait for 200 ns;
  ALU_SELECT <= "1101";
  wait for 200 ns;
  ALU_SELECT <= "1010";
  wait for 200 ns;
  ALU_SELECT <= "1011";
  wait for 200 ns;
  ALU_SELECT <= "0010";
  wait for 200 ns;
  ALU_SELECT <= "0001";
  wait for 200 ns;
  ALU_SELECT <= "0100";
  wait for 200 ns;
  ALU_SELECT <= "0110";
  wait for 200 ns;
  ALU_SELECT <= "1111";
  wait for 200 ns;
  ALU_SELECT <= "1110";
  wait for 200 ns;
      wait;
end process STM;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alu of alu_tb is
	for TB_ARCHITECTURE
		for UUT : alu
			use entity work.alu(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_alu;

