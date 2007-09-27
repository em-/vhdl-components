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
    variable T_Q: std_logic;
    variable JK: std_logic_vector (1 downto 0);
begin
    if RST = '1' then
        T_Q := '0';
    elsif CLK'event and CLK = '1' then
        JK := J & K;
        case JK is
            when "00" =>
                T_Q := T_Q;
            when "10" =>
                T_Q := '1';
            when "01" =>
                T_Q := '0';
            when "11" =>
                T_Q := 'X';
        end case;
    end if;
    Q <= T_Q;
end process;
end behavioral_async;

architecture behavioral_sync of fjk is
begin
process (CLK)
    variable T_Q: std_logic;
    variable JK: std_logic_vector (1 downto 0);
begin
    if CLK'event and CLK = '1' then
        JK := J & K;
        if RST = '1' then
            T_Q := '0';
        else
            case JK is
                when "00" =>
                    T_Q := T_Q;
                when "10" =>
                    T_Q := '1';
                when "01" =>
                    T_Q := '0';
                when "11" =>
                    T_Q := 'X';
            end case;
        end if;
        Q <= T_Q;
    end if;
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
