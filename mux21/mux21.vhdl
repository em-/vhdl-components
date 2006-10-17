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
