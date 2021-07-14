library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RAM is
	generic (blocksize : integer := 1024);

	port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (31 downto 0);
		databus : inout std_logic_vector (31 downto 0);
		memdataready : out std_logic);
end entity;

architecture behavioral of RAM is
	type mem is array (0 to blocksize - 1) of std_logic_vector (32 downto 0);

	signal buffermem : mem := (others => (others => '0'));

begin
	process (clk)
		variable ad : integer;
		variable init : boolean := true;
	begin
		if init = true then

			buffermem(0) <= "01010000010001110000000000011000";

			init := false;
		end if;

		--
		memdataready <= '0';

		if  clk'event and clk = '1' then
			ad := to_integer(unsigned(addressbus));

			if readmem = '1' then -- Reading :)
				memdataready <= '1';
				if ad >= blocksize then
					databus <= (others => 'Z');
				else
					databus <= buffermem(ad);
				end if;
			elsif writemem = '1' then -- Writing :)
				memdataready <= '1';
				if ad < blocksize then
					buffermem(ad) <= databus;
				end if;
			else
				databus <= (others => 'Z');
			end if;
		end if;
	end process;

end architecture;
