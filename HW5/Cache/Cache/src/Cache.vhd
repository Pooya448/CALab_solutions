library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Cache is
	port (
	CLK : in std_logic;
	WRITE_ENABLE0 : in std_logic;
	WRITE_ENABLE1 : in std_logic;
	ADDR: in std_logic_vector (31 downto 0);
	WRITE_DATA : in std_logic_vector (31 downto 0);
	DATA : out std_logic_vector (31 downto 0);
	HIT : out std_logic
	);
end entity;

architecture behavioral of Cache is

	component MISS_OR_HIT is
	port (
	TAG : in std_logic_vector(22 downto 0);
	W0 : in std_logic_vector(23 downto 0);
	W1 : in std_logic_vector(23 downto 0);
	HIT : out std_logic;
	W0_V : out std_logic;
	W1_V : out std_logic
	);
	end component;

	component TAG_VALID is
	port(
	ADDR : in std_logic_vector(5 downto 0);
	WRITE_DATA : in std_logic_vector(22 downto 0);
	WRITE_ENABLE : in std_logic;
	NOT_VALID : in std_logic;
	CLK : in std_logic;
	RESET : in std_logic;
	OUTPUT : out std_logic_vector(23 downto 0)
	);
	end component;

	component DATA_MEM is
	port (
	CLK : in std_logic;
	ADDR : in std_logic_vector(5 downto 0);
	OFFSET : in std_logic_vector(2 downto 0);
	WRITE_DATA : in std_logic_vector(31 downto 0);
	WRITE_EN : in std_logic;
	DATA : out std_logic_vector(31 downto 0)
	);
	end component;

	signal CACH_OFFSET : std_logic_vector(2 downto 0);
	signal CACH_ADDR : std_logic_vector(8 downto 3);
	signal CACH_TAG : std_logic_vector(31 downto 9);

	signal DM0_OUT , DM1_OUT : std_logic_vector(31 downto 0);

	signal TV0_OUT , TV1_OUT : std_logic_vector(23 downto 0);

	signal HIT_R , HIT_R0 , HIT_R1 : std_logic;
	signal RESET , NOT_VALID : std_logic;

begin

	CACH_OFFSET <= ADDR(2 downto 0);
	CACH_ADDR <= ADDR(8 downto 3);
	CACH_TAG <= ADDR(31 downto 9);

	Way0DA : DATA_MEM port map (CLK, CACH_ADDR, CACH_OFFSET, WRITE_DATA, WRITE_ENABLE0, DM0_OUT);
	Way1DA : DATA_MEM port map (CLK, CACH_ADDR, CACH_OFFSET, WRITE_DATA, WRITE_ENABLE1, DM1_OUT);

	Way0TV : TAG_VALID port map (CACH_ADDR, CACH_TAG, WRITE_ENABLE0, NOT_VALID, CLK, RESET, TV0_OUT);
	Way1TV : TAG_VALID port map (CACH_ADDR, CACH_TAG, WRITE_ENABLE1, NOT_VALID, CLK, RESET, TV1_OUT);

	MHL : MISS_OR_HIT port map (CACH_TAG, TV0_OUT, TV1_OUT, HIT_R, HIT_R0, HIT_R1);

	DATA <= DM0_OUT when HIT_R0 = '1' else
			DM1_OUT when HIT_R1 = '1' else
			(others => 'Z');

	HIT <= (HIT_R1 or HIT_R0);

end architecture;
