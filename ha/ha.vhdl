library ieee; 
use ieee.std_logic_1164.all; 

entity ha is
    generic (DELAY_S, DELAY_Co: time := 0 ns);
    port (A, B: in  std_logic;
          S:    out std_logic;
          Co:   out std_logic);
end ha; 

architecture logic of ha is
begin
  S <= A xor B after DELAY_S;
  Co <= A and B after DELAY_Co;
end logic;
