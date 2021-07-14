Library ieee;
Use ieee.std_logic_1164.all;

entity full_adder_8_bit is
port (A, B: in Std_logic_vector(7 downto 0);
cin: in Std_logic;
sum: out Std_logic_vector(7 downto 0);
carry:out Std_logic);
end full_adder_8_bit;

architecture Full_Adder_8_arch of full_adder_8_bit is

component full_adder is
	port (a,b,cin :in Std_logic;
      sum,carry : out Std_logic);
end component;

	signal c: Std_logic_vector(6 downto 0);
begin
stage0: full_adder port map (A(0), B(0), cin, sum(0), c(0));
stage1: full_adder port map (A(1), B(1), c(0), sum(1), c(1));
stage2: full_adder port map (A(2), B(2), c(1), sum(2), c(2));
stage3: full_adder port map (A(3), B(3), c(2), sum(3), c(3));
stage4: full_adder port map (A(4), B(4), c(3), sum(4), c(4));
stage5: full_adder port map (A(5), B(5), c(4), sum(5), c(5));
stage6: full_adder port map (A(6), B(6), c(5), sum(6), c(6));
stage7: full_adder port map (A(7), B(7), c(6), sum(7), carry);
end Full_Adder_8_arch;

------------------------------------------------------------------------------------

library IEEE;
Use IEEE. STD_LOGIC_1164.all;

entity full_adder IS
port (a,b,cin :in Std_logic;
      sum,carry : out Std_logic);
end full_adder;

architecture Full_Adder_arch of full_adder is

component half_adder is
port (a,b :in Std_logic;
      s,carry: out Std_logic);
end component;

component or_gate is
port (x,y :in Std_logic;
      o: out Std_logic);
end component;

signal s1,c1,c2 : Std_logic;
begin
 stage0: half_adder port map (a,b,s1,c1);
 stage1: half_adder port map (s1,cin,sum,c2);
 stage2: or_gate port map (c1,c2,carry);
end Full_Adder_arch;

------------------------------------------------------------------------------------

library IEEE;
Use IEEE. STD_LOGIC_1164.all;

entity half_adder is
      port (a,b : in Std_logic;
      s, carry : out Std_logic);
end half_adder;
architecture half_adder_arch of half_adder IS
 begin
      s <= a xor b;
      carry <= a and b;
end half_adder_arch;

------------------------------------------------------------------------------------

library IEEE;
Use IEEE. STD_LOGIC_1164.all;

entity or_gate is
      port (x, y:in Std_logic;
      o: out Std_logic);
end or_gate;
architecture or_gate_arch of or_gate IS
 begin
      o <= x or y;
end or_gate_arch;
