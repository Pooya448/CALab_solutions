library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MISS_OR_HIT is
	port (
		TAG : in std_logic_vector(22 downto 0);
		W0 : in std_logic_vector(23 downto 0);
		W1 : in std_logic_vector(23 downto 0);
		HIT : out std_logic;
		W0_V : out std_logic;
		W1_V : out std_logic
	);
end entity;

architecture behavioral of MISS_OR_HIT is
begin

	W0_V <= '1' when W0 = '1' & TAG else '0';
	W1_V <= '1' when W1 = '1' & TAG else '0';
	HIT <= '1' when '1' & TAG = W0 or '1' & TAG = W1 else '0';

end architecture;
