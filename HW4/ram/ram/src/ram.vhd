								library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
---------------------------------------------
entity ram is
port(   CLK: in std_logic;
        ENABLE : in std_logic;
        DATA_IN : in std_logic_vector(31 downto 0);
        ADDR_IN0 : in std_logic_vector(9 downto 0);
        ADDR_IN1 : in std_logic_vector(9 downto 0);
        PORT_EN0 : in std_logic;
        PORT_EN1 : in std_logic;
        DATA_OUT0 : out std_logic_vector(31 downto 0);
        DATA_OUT1 : out std_logic_vector(31 downto 0)
    );
end ram;

architecture Behavioral of ram is

type ram_type is array(0 to 1023) of std_logic_vector(31 downto 0);
signal ram : ram_type := (others => (others => '0'));

begin

process(CLK)
begin
    if(rising_edge(CLK)) then
        if(PORT_EN0 = '1') then
            if(ENABLE = '1') then  
                ram(conv_integer(ADDR_IN0)) <= DATA_IN;
            end if;
        end if;
    end if;
end process;

DATA_OUT0 <= ram(conv_integer(ADDR_IN0)) when (PORT_EN0 = '1') else
            (others => 'Z');
DATA_OUT1 <= ram(conv_integer(ADDR_IN1)) when (PORT_EN1 = '1') else
            (others => 'Z');

end Behavioral;
