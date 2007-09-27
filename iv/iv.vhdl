library ieee;
use ieee.std_logic_1164.all;

entity iv is
    port (I: in  std_logic;
          O: out std_logic);
end iv;


architecture behavioral of iv is
begin
    O <= not (I);
end behavioral;

architecture behavioral_delay of iv is
    constant IVDELAY: time := 0.1 ns;
begin
    O <= not (I) after IVDELAY;
end behavioral_delay;


configuration cfg_iv_behavioral of iv is
    for behavioral
    end for;
end cfg_iv_behavioral;

configuration cfg_iv_behavioral_delay of iv is
    for behavioral_delay
    end for;
end cfg_iv_behavioral_delay;
