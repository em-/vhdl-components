library ieee;
use ieee.std_logic_1164.all;

entity and2 is
    port (A, B: in  std_logic;
          O:    out std_logic);
end and2;


architecture logic of and2 is
begin
    O <= A and B;
end logic;
