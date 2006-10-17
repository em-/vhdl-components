library ieee; 
use ieee.std_logic_1164.all; 

entity mux21_1bit is
    port (A, B: in  std_logic;
          SEL:  in  std_logic;
          O:    out std_logic);
end mux21_1bit;

architecture behavioral of mux21_1bit is
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
