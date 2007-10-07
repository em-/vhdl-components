library ieee;
use ieee.std_logic_1164.all;

entity fd is
    port (CLK, RST: in  std_logic;
          D:        in  std_logic;
          Q:        out std_logic);
end fd;

architecture behavioral_async of fd is
begin
process (CLK, RST)
begin
    if RST = '1' then
        Q <= '0';
    elsif rising_edge(CLK) then
        Q <= D;
    end if;
end process;
end behavioral_async;

architecture behavioral_sync of fd is
begin
process (CLK)
begin
    if rising_edge(CLK) then
        if RST = '1' then
            Q <= '0';
        else
            Q <= D;
        end if;
    end if;
end process;
end behavioral_sync;


configuration cfg_fd_behavioral_async of fd is
    for behavioral_async
    end for;
end cfg_fd_behavioral_async;

configuration cfg_fd_behavioral_sync of fd is
    for behavioral_sync
    end for;
end cfg_fd_behavioral_sync;
