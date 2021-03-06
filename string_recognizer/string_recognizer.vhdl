library ieee;
use ieee.std_logic_1164.all;

entity string_recognizer is
    port (CLK, RST: in  std_logic;
          I:        in  std_logic;
          O:        out std_logic);
end string_recognizer;

architecture behavioral of string_recognizer is
    type state_t is (S, S0, S01, S010, S0100);
    signal current_state, next_state: state_t;

begin
    process (CLK, RST)
    begin
        if RST='1' then
            current_state <= S;
        elsif rising_edge(CLK) then
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
                O <= '0';
                if I='0' then
                    next_state <= S010;
                else
                    next_state <= S;
                end if;
            when S010 =>
                O <= '0';
                if I='0' then
                    next_state <= S0100;
                else
                    next_state <= S01;
                end if;
            when S0100 =>
                O <= '1';
                if I='0' then
                    next_state <= S0;
                else
                    next_state <= S;
                end if;
            when others =>
                next_state <= S;
        end case;
    end process;
end behavioral;
