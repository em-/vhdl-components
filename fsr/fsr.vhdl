library ieee;
use ieee.std_logic_1164.all;

entity fsr is
    port (CLK, RST: in  std_logic;
          S, R:     in  std_logic;
          Q:        out std_logic);
end fsr;

architecture behavioral_async of fsr is
begin
process (CLK, RST)
    variable SR: std_logic_vector (1 downto 0);
begin
    if RST = '1' then
        Q <= '0';
    elsif rising_edge(CLK) then
        SR := S & R;
        case SR is
            when "00" =>
            when "10" =>
                Q <= '1';
            when "01" =>
                Q <= '0';
            when "11" =>
                Q <= 'X';
            when others => null;
        end case;
    end if;
end process;
end behavioral_async;

architecture behavioral_sync of fsr is
begin
process (CLK)
    variable SR: std_logic_vector (1 downto 0);
begin
    if rising_edge(CLK) then
        if RST = '1' then
            Q <= '0';
        else
            SR := S & R;
            case SR is
                when "00" =>
                when "10" =>
                    Q <= '1';
                when "01" =>
                    Q <= '0';
                when "11" =>
                    Q <= 'X';
            end case;
        end if;
    end if;
end process;
end behavioral_sync;


configuration cfg_fsr_behavioral_async of fsr is
    for behavioral_async
    end for;
end cfg_fsr_behavioral_async;

configuration cfg_fsr_behavioral_sync of fsr is
    for behavioral_sync
    end for;
end cfg_fsr_behavioral_sync;
