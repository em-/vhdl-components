library ieee;
use ieee.std_logic_1164.all;

entity fa is
    generic (DELAY_S, DELAY_Co: time := 0 ns);
    port (A, B: in  std_logic;
          Ci:   in  std_logic;
          S:    out std_logic;
          Co:   out std_logic);
end fa;

architecture logic of fa is
begin
    S <= A xor B xor Ci after DELAY_S;
    Co <= (A and B) or (A and Ci) or (B and Ci) after DELAY_Co;
end logic;

architecture behavioral of fa is
begin
    process (A, B, Ci)
        variable input: std_logic_vector (2 downto 0);
    begin
        input := A & B & Ci;
        case input is
            when "000" =>
                S  <= '0' after DELAY_S;
                Co <= '0' after DELAY_Co;
            when "001" =>
                S  <= '1' after DELAY_S;
                Co <= '0' after DELAY_Co;
            when "010" =>
                S  <= '1' after DELAY_S;
                Co <= '0' after DELAY_Co;
            when "011" =>
                S  <= '0' after DELAY_S;
                Co <= '1' after DELAY_Co;
            when "100" =>
                S  <= '1' after DELAY_S;
                Co <= '0' after DELAY_Co;
            when "101" =>
                S  <= '0' after DELAY_S;
                Co <= '1' after DELAY_Co;
            when "110" =>
                S  <= '0' after DELAY_S;
                Co <= '1' after DELAY_Co;
            when "111" =>
                S  <= '1' after DELAY_S;
                Co <= '1' after DELAY_Co;
            when others  => null;
        end case;
    end process;
end behavioral;


configuration cfg_fa_logic of fa is
    for logic
    end for;
end cfg_fa_logic;

configuration cfg_fa_behavioral of fa is
    for behavioral
    end for;
end cfg_fa_behavioral;
