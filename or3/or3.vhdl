library ieee;
use ieee.std_logic_1164.all;

entity or3 is
    port (A, B, C: in  std_logic;
          O:       out std_logic);
end or3;


architecture logic of or3 is
begin
    O <= A or B or C;
end logic;
