library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Cache is
	port (
	clk, wen0 , wen1, wen2, wen3 : in std_logic;
	address: in std_logic_vector (31 downto 0);
	wdata : in std_logic_vector (31 downto 0);
	data : out std_logic_vector (31 downto 0);
	hit0 , hit1, hit2 , hit3 : out std_logic
	);
end entity;

architecture behavioral of Cache is

	component MHLogic is
	port (
	tag : in std_logic_vector(23 downto 0);
	w0 : in std_logic_vector(24 downto 0);
	w1 : in std_logic_vector(24 downto 0);
	w2 : in std_logic_vector(24 downto 0);
	w3 : in std_logic_vector(24 downto 0);
	hit : out std_logic;
	w0v : out std_logic;
	w1v : out std_logic;
	w2v : out std_logic;
	w3v : out std_logic
	);
	end component;

	component TVArray is
	port(
	clk : in std_logic;
	reset_n : in std_logic;
	address : in std_logic_vector(5 downto 0);
	writeEn : in std_logic;
	invalidate : in std_logic;
	writeData : in std_logic_vector(23 downto 0);
	output : out std_logic_vector(24 downto 0)
	);
	end component;

	component DataArray is
	port (
	clk : in std_logic;
	address : in std_logic_vector(5 downto 0);
	offset : in std_logic_vector(1 downto 0);
	writeEn : in std_logic;
	writeData : in std_logic_vector(32 downto 0);
	data : out std_logic_vector(32 downto 0)
	);
	end component;

	signal CacheAddress : std_logic_vector(7 downto 2);
	signal CacheTag : std_logic_vector(31 downto 8);
	signal CacheOffset : std_logic_vector(1 downto 0)

	-- Data Array Outputs
	signal DA0_out , DA1_out, DA2_out, DA3_out : std_logic_vector(31 downto 0);

	-- Tag / Valid Outputs
	signal TV0_out , TV1_out, TV2_out , TV3_out : std_logic_vector(24 downto 0);

	signal hitR , hitR0 , hitR1, hitR2 , hitR3 : std_logic;
	signal reset_n , invalidate : std_logic;

	-- FSM
	--type state_type is (start,st_read,st_write);
	--signal cur_state : state_type := start;
	--signal next_state : state_type;

begin

	CacheAddress <= address(5 downto 0);
	CacheTag <= address(9 downto 6);

	W0D : DataArray port map (clk,CacheAddress,wen0,wdata,DA0_out);
	W1D : DataArray port map (clk,CacheAddress,wen1,wdata,DA1_out);
	W2D : DataArray port map (clk,CacheAddress,wen2,wdata,DA2_out);
	W3D : DataArray port map (clk,CacheAddress,wen3,wdata,DA3_out);

	W0T : TVArray port map (clk,reset_n,CacheAddress,wen0,invalidate,CacheTag,TV0_out);
	W1T : TVArray port map (clk,reset_n,CacheAddress,wen1,invalidate,CacheTag,TV1_out);
	W2T : TVArray port map (clk,reset_n,CacheAddress,wen2,invalidate,CacheTag,TV2_out);
	W3T : TVArray port map (clk,reset_n,CacheAddress,wen3,invalidate,CacheTag,TV3_out);

	MHL : MHLogic port map (CacheTag,TV0_out,TV1_out,TV2_out,TV3_out,hitR,hitR0,hitR1,hitR2,hitR3);

	data <= DA0_out when hitR0 = '1' else
			DA1_out when hitR1 = '1' else
			DA2_out when hitR2 = '1' else
			DA3_out when hitR3 = '1' else
			(others => 'Z');

	hit0 <= hitR0;
	hit1 <= hitR1;
	hit2 <= hitR2;
	hit3 <= hitR3;

end architecture;
