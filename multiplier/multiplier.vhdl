library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity multiplier is
    generic (N: integer := 4);
    port (A, B:     in  std_logic_vector (N-1 downto 0);
          O:        out std_logic_vector (2*N-1 downto 0)
    );
end multiplier;

architecture behavioral of multiplier is
begin
    O <= std_logic_vector(unsigned(unsigned(A) * unsigned(B)));
end behavioral;


configuration cfg_multiplier_behavioral of multiplier is
    for behavioral
    end for;
end cfg_multiplier_behavioral;
