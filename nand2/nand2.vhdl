library ieee;
use ieee.std_logic_1164.all;

entity nand2 is
    generic (DELAY: time := 0 ns);
    port (A, B: in  std_logic;
          O:    out std_logic);
end nand2;


architecture logic of nand2 is
begin
    O <= not (A and B) after DELAY;
end logic;

architecture logic_transport of nand2 is
begin
    O <= transport not (A and B) after DELAY;
end logic_transport;

architecture behavioral of nand2 is
begin
    process (A, B)
    begin
        if A = '1' and B = '1' then
            O <= '0' after DELAY;
        else
            O <= '1' after DELAY;
        end if;
    end process;
end behavioral;


configuration cfg_nand2_logic of nand2 is
    for logic
    end for;
end cfg_nand2_logic;

configuration cfg_nand2_logic_transport of nand2 is
    for logic_transport
    end for;
end cfg_nand2_logic_transport;

configuration cfg_nand2_behavioral of nand2 is
    for behavioral
    end for;
end cfg_nand2_behavioral;
