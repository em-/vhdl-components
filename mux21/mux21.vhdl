library ieee;
use ieee.std_logic_1164.all;

entity mux21 is
    generic (N: integer := 8);

    port (A, B: in  std_logic_vector (N-1 downto 0);
          SEL:  in  std_logic;
          O:    out std_logic_vector (N-1 downto 0) );
end mux21;

architecture behavioral of mux21 is
begin
process (A, B, SEL)
begin
    if SEL = '0' then
        O <= A;
    else
        O <= B;
    end if;
end process;
end behavioral;

architecture structural of mux21 is
    component mux21_1bit
        port (A, B: in  std_logic;
              SEL:  in  std_logic;
              O:    out std_logic);
    end component;
begin
    mux_vect: for i in 0 to N-1
    generate
        mux_i: mux21_1bit port map (A(i), B(i), SEL, O(i));
    end generate;
end structural;


configuration cfg_mux21_behavioral of mux21 is
    for behavioral
    end for;
end cfg_mux21_behavioral;

configuration cfg_mux21_structural of mux21 is
    for structural
    end for;
end cfg_mux21_structural;
