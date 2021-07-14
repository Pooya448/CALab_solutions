library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DATA_MEM is
	port (
		CLK : in std_logic;
		ADDR : in std_logic_vector(5 downto 0);
		OFFSET : in std_logic_vector(2 downto 0);
		WRITE_DATA : in std_logic_vector(31 downto 0);
		WRITE_EN : in std_logic;
		DATA : out std_logic_vector(31 downto 0)
	);
end entity;

architecture behavioral of DATA_MEM is
	type MEM is array (0 to 63, 0 to 7) of std_logic_vector (31 downto 0);
	signal MEM_BUFFER : MEM := (others => (others => (others => '0')));

begin

	process (CLK)
	begin
		DATA <= MEM_BUFFER(to_integer(unsigned(ADDR)), to_integer(unsigned(OFFSET)));
		if rising_edge(CLK) then
			if WRITE_EN = '1' then
				MEM_BUFFER(to_integer(unsigned(ADDR)), to_integer(unsigned(OFFSET))) <= WRITE_DATA;
			end if;
		end if;

	end process;

end architecture;
