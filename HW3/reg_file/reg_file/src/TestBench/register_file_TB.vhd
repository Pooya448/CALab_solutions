library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity register_file_tb is
end register_file_tb;

architecture TB_ARCHITECTURE of register_file_tb is
	-- Component declaration of the tested unit
	component register_file
	port(
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		RegWrite : in STD_LOGIC;
		WriteReg : in STD_LOGIC_VECTOR(4 downto 0);
		Data : in STD_LOGIC_VECTOR(31 downto 0);
		readreg1 : in STD_LOGIC_VECTOR(4 downto 0);
		read1 : out STD_LOGIC_VECTOR(31 downto 0);
		readreg2 : in STD_LOGIC_VECTOR(4 downto 0);
		read2 : out STD_LOGIC_VECTOR(31 downto 0) );
	end component;

	constant CLK_FREQ : integer := 10e8; -- 100 MHz
    constant CLK_P    : time    := 5000 ms / CLK_FREQ;
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC := '0';
	signal RST : STD_LOGIC;
	signal RegWrite : STD_LOGIC;
	signal WriteReg : STD_LOGIC_VECTOR(4 downto 0);
	signal Data : STD_LOGIC_VECTOR(31 downto 0);
	signal readreg1 : STD_LOGIC_VECTOR(4 downto 0);
	signal readreg2 : STD_LOGIC_VECTOR(4 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal read1 : STD_LOGIC_VECTOR(31 downto 0);
	signal read2 : STD_LOGIC_VECTOR(31 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : register_file
		port map (
			CLK => CLK,
			RST => RST,
			RegWrite => RegWrite,
			WriteReg => WriteReg,
			Data => Data,
			readreg1 => readreg1,
			read1 => read1,
			readreg2 => readreg2,
			read2 => read2
		);

	CLK <= not CLK after CLK_P / 2;
	
	-- Add your stimulus here ...  
	STM: process
	begin
	
	wait for 200ns;
	
	RST <= '0';
	WriteReg <= "10011";
	Data <= "00000100001011101111101011011100";
	Regwrite <= '1';   	
	
	wait for 200ns;
	
	RST <= '0';
	WriteReg <= "00100";
	Data <= "10000000101011011000100100101100";
	Regwrite <= '1';   
	
	wait for 200ns;	
	
	readreg1 <= "10011";	
	readreg2 <= "00100";
	Regwrite <= '0';
	wait;	  
	
	end process STM;
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_register_file of register_file_tb is
	for TB_ARCHITECTURE
		for UUT : register_file
			use entity work.register_file(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_register_file;

