
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;
-----------------------------------------------
---------- ALU 8-bit VHDL ---------------------
-----------------------------------------------
entity ALU is
  generic (
     constant SHIFT: natural := 1
    );

    Port (
    IN1, IN2     : in  STD_LOGIC_VECTOR(7 downto 0);
    ALU_SELECT  : in  STD_LOGIC_VECTOR(3 downto 0);
    ALU_OUTPUT   : out  STD_LOGIC_VECTOR(7 downto 0);
    CARRY_OUT : out std_logic
    );
end ALU;
architecture Behavioral of ALU is

signal ALU_RESULT : std_logic_vector (7 downto 0);
signal TEMP: std_logic_vector (8 downto 0);

begin
   process(IN1, IN2, ALU_SELECT)
 begin
  case(ALU_SELECT) is

  when "1000" =>
   ALU_RESULT <= IN1 + IN2 ;

  when "1001" =>
   ALU_RESULT <= IN1 - IN2 ;

  when "1100" =>
   ALU_RESULT <= std_logic_vector(unsigned(IN1) sll SHIFT);

  when "1101" =>
   ALU_RESULT <= std_logic_vector(unsigned(IN1) srl SHIFT);

  when "1010" =>
   ALU_RESULT <= std_logic_vector(unsigned(IN1) rol SHIFT);

  when "1011" =>
   ALU_RESULT <= std_logic_vector(unsigned(IN1) ror SHIFT);

  when "0000" | "0001" =>
   ALU_RESULT <= IN1 and IN2;

  when "0010" | "0011" =>
   ALU_RESULT <= IN1 or IN2;

  when "0101" | "0100" =>
   ALU_RESULT <= IN1 xor IN2;

  when "0110" | "0111" =>
   ALU_RESULT <= IN1 xor IN1;

  when "1111" =>
   ALU_RESULT   <= std_logic_vector(shift_right(signed(IN1), SHIFT));

  when "1110" =>
   ALU_RESULT   <= std_logic_vector(shift_left(signed(IN1), SHIFT));

  when others => ALU_RESULT <= IN1 + IN2 ;
  end case;
 end process;
 ALU_OUTPUT <= ALU_RESULT;
 TEMP <= ('0' & IN1) + ('0' & IN2);
 CARRY_OUT <= TEMP(8);
end Behavioral;
