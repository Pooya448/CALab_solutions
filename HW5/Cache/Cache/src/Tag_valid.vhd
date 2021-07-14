library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TAG_VALID is
	port(

		ADDR : in std_logic_vector(5 downto 0);
		WRITE_DATA : in std_logic_vector(22 downto 0);
		WRITE_ENABLE : in std_logic;
		NOT_VALID : in std_logic;
		CLK : in std_logic;
		RESET : in std_logic;
		OUTPUT : out std_logic_vector(23 downto 0)
	);
end entity;

architecture behavioral of TAG_VALID is
	type MEM is array (0 to 63) of std_logic_vector (23 downto 0);
	signal MEM_BUFFER : MEM := (others => (others => '0'));

begin

	OUTPUT <= MEM_BUFFER(to_integer(unsigned(ADDR)));

	process (CLK)
	begin

		if rising_edge(CLK) then

			if RESET = '1' then
				MEM_BUFFER <= (others => (others => '0'));
			end if;

			if NOT_VALID = '1' then
				MEM_BUFFER(to_integer(unsigned(ADDR)))(0) <= '0';
			end if;

			if WRITE_ENABLE = '1' then
				MEM_BUFFER(to_integer(unsigned(ADDR))) <= "1" & WRITE_DATA;
			end if;

		end if;

	end process;

end architecture;
