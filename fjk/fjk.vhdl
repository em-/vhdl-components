library ieee;
use ieee.std_logic_1164.all;

entity fjk is
    port (CLK, RST: in  std_logic;
          J, K:     in  std_logic;
          Q:        out std_logic);
end fjk;

architecture behavioral_async of fjk is
begin
process (CLK, RST)
    variable JK: std_logic_vector (1 downto 0);
    variable s: std_logic;
begin
    if RST = '1' then
        s := '0';
    elsif rising_edge(CLK) then
        JK := J & K;
        case JK is
            when "00" => when "10" =>
                s := '1';
            when "01" =>
                s := '0';
            when "11" =>
                s := not s;
            when others => null;
        end case;
    end if;
    Q <= s;
end process;
end behavioral_async;

architecture behavioral_sync of fjk is
begin
process (CLK)
    variable JK: std_logic_vector (1 downto 0);
    variable s: std_logic;
begin
    if rising_edge(CLK) then
        if RST = '1' then
            s := '0';
        else
            JK := J & K;
            case JK is
                when "00" =>
                when "10" =>
                    s := '1';
                when "01" =>
                    s := '0';
                when "11" =>
                    s := not s;
            end case;
        end if;
    end if;
    Q <= s;
end process;
end behavioral_sync;


configuration cfg_fjk_behavioral_async of fjk is
    for behavioral_async
    end for;
end cfg_fjk_behavioral_async;

configuration cfg_fjk_behavioral_sync of fjk is
    for behavioral_sync
    end for;
end cfg_fjk_behavioral_sync;
