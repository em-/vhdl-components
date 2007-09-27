library ieee;
use ieee.std_logic_1164.all;

entity exor is
    port (A, B: in  std_logic;
          O:    out std_logic);
end exor;

architecture logic of exor is
begin
    O <= A xor B;
end logic;

architecture behavioral of exor is
begin
    process (A, B)
    begin
        if A /= B then
            O <= '1';
        else
            O <= '0';
        end if;
    end process;
end behavioral;

configuration cfg_exor_logic of exor is
    for logic
    end for;
end cfg_exor_logic;

configuration cfg_exor_behavioral of exor is
    for behavioral
    end for;
end cfg_exor_behavioral;

