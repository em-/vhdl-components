library ieee; 
use ieee.std_logic_1164.all; 

entity ha is
    port (A, B: in  std_logic;
          S:    out std_logic;
          Co:   out std_logic);
end ha; 

architecture logic of ha is
begin
  S <= A xor B;
  Co <= A and B;
end logic;
