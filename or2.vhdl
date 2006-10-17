library ieee;
use ieee.std_logic_1164.all;

entity or2 is
    port (A, B: in  std_logic;
          O:    out std_logic);
end or2;


architecture logic of or2 is
begin
    O <= A or B;
end logic;
