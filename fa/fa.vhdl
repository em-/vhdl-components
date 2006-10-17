library ieee; 
use ieee.std_logic_1164.all; 

entity fa is
    port (A, B: in  std_logic;
          Ci:   in  std_logic;
          S:    out std_logic;
          Co:   out std_logic);
end fa; 

architecture logic of fa is
begin
  S <= A xor B xor Ci;
  Co <= (A and B) or (A and Ci) or (B and Ci);
end logic;
