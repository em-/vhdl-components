library ieee; 
use ieee.std_logic_1164.all; 

entity fd is
    port (CLK, RST: in  std_logic;
          EN:       in  std_logic;
          D:        in  std_logic;
          Q:        out std_logic);
end fd;

architecture behavioral of fd is
begin
process (CLK, RST)
begin
    if RST = '0' then
        Q <= '0';
    elsif rising_edge(CLK) then
        if EN = '0' then
            Q <= D;
        end if;
    end if;
end process;
end behavioral;
