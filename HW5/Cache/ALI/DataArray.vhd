library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DataArray is
	port (
		clk : in std_logic;
		address : in std_logic_vector(5 downto 0);
		offset : in std_logic_vector(1 downto 0);
		writeEn : in std_logic;
		writeData : in std_logic_vector(32 downto 0);
		data : out std_logic_vector(32 downto 0)
	);
end entity;

architecture behavioral of DataArray is
	type mem is array (0 to 63, 0 to 3) of std_logic_vector (31 downto 0);
	signal buffermem : mem := (others => (others => '0'));

begin

	data <= buffermem(to_integer(unsigned(address)),  to_integer(unsigned(offset)));

	process (clk)
	begin

		if rising_edge(clk) then
			if writeEn = '1' then
				buffermem(to_integer(unsigned(address)),  to_integer(unsigned(offset))) <= writeData;
			end if;
		end if;

	end process;

end architecture;
