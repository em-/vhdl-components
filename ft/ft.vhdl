library ieee;
use ieee.std_logic_1164.all;

library std;
use std.textio.all;
use ieee.std_logic_textio.all; -- synopsys only

entity ft is
    port (CLK, RST: in  std_logic;
          T:        in  std_logic;
          Q:        out std_logic);
end ft;

architecture behavioral_async of ft is
begin

process (CLK, RST)
    variable d: std_logic;
begin
    if RST = '0' then
        d := '0';
    elsif rising_edge(CLK) then
        if T = '1' then
            d := not d;
        else
            d := d;
        end if;
    end if;
    Q <= d;
end process;
end behavioral_async;

architecture behavioral_sync of ft is
begin

process (CLK, RST)
    variable d: std_logic;
begin
    if rising_edge(CLK) then
        if RST = '0' then
            d := '0';
        elsif T = '1' then
            d := not d;
        else
            d := d;
        end if;
    end if;
    Q <= d;
end process;
end behavioral_sync;

configuration cfg_ft_behavioral_async of ft is
    for behavioral_async
    end for;
end cfg_ft_behavioral_async;

configuration cfg_ft_behavioral_sync of ft is
    for behavioral_sync
    end for;
end cfg_ft_behavioral_sync;
