library ieee;
use ieee.std_logic_1164.all;

entity or2 is
    generic (DELAY: time := 0 ns);
    port (A, B: in  std_logic;
          O:    out std_logic);
end or2;


architecture logic of or2 is
begin
    O <= (A or B) after DELAY;
end logic;

architecture logic_transport of or2 is
begin
    O <= transport (A or B) after DELAY;
end logic_transport;


architecture behavioral of or2 is
begin
    process (A, B)
    begin
        if A = '1' then
            O <= '1';
        elsif B = '1' then
            O <= '1';
        else
            O <= '0';
        end if;
    end process;
end behavioral;


configuration cfg_or2_logic of or2 is
	for logic
	end for;
end cfg_or2_logic;

configuration cfg_or2_logic_transport of or2 is
	for logic_transport
	end for;
end cfg_or2_logic_transport;

configuration cfg_or2_behavioral of or2 is
	for behavioral
	end for;
end cfg_or2_behavioral;
