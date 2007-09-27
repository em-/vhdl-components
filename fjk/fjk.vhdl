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
        if    JK = "00" then
            T_Q := T_Q;
        elsif JK = "10" then
            T_Q := '1';
        elsif JK = "01" then
            T_Q := '0';
        elsif JK = "11" then
            T_Q := 'X';
        end if;
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
        elsif JK = "00" then
            T_Q := T_Q;
        elsif JK = "10" then
            T_Q := '1';
        elsif JK = "01" then
            T_Q := '0';
        elsif JK = "11" then
            T_Q := 'X';
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
