library ieee;
use ieee.std_logic_1164.all;

entity ld_en is
    port (CLK, RST: in  std_logic;
          EN:       in  std_logic;
          D:        in  std_logic;
          Q:        out std_logic);
end ld_en;

architecture behavioral of ld_en is
begin
process (CLK, RST, D)
begin
    if RST = '1' then
        Q <= '0';
    elsif CLK = '0' then
        if EN = '1' then
            Q <= D;
        end if;
    end if;
end process;
end behavioral;
