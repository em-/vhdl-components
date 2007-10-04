library ieee;
use ieee.std_logic_1164.all;

entity string_recognizer is
    port (CLK, RST: in  std_logic;
          I:        in  std_logic;
          O:        out std_logic);
end string_recognizer;

architecture behavioral of string_recognizer is
    type state_t is (S, S0, S01, S010);
    signal current_state, next_state: state_t;

begin
    process (CLK, RST)
    begin
        if RST='1' then
            current_state <= S;
        elsif CLK'event and CLK='1' then
            current_state <= next_state;
        end if;
    end process;

    process (current_state, I)
    begin
        case current_state is
            when S =>
                O <= '0';
                if I='0' then
                    next_state <= S0;
                else
                    next_state <= S;
                end if;
            when S0 =>
                O <= '0';
                if I='0' then
                    next_state <= S0;
                else
                    next_state <= S01;
                end if;
            when S01 =>
                if I='0' then
                    O <= '1';
                    next_state <= S010;
                else
                    O <= '0';
                    next_state <= S;
                end if;
            when S010 =>
                O <= '0';
                if I='0' then
                    next_state <= S0;
                else
                    next_state <= S;
                end if;
        end case;
    end process;
end behavioral;
