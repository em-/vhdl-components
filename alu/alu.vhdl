library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_operations.all;

entity alu is
    generic (N : integer := 8);
    port (FUNC:         in  ALU_OPERATION;
          DATA1, DATA2: in  std_logic_vector(N-1 downto 0);
          O:            out std_logic_vector(N-1 downto 0));
end alu;

architecture behavioral of alu is
begin
    process (FUNC, DATA1, DATA2)
        subtype LOW_HALF is natural range (N/2)-1 downto 0;
        variable UD1, UD2: unsigned (DATA1'Range);
    begin
        UD1 := unsigned(DATA1);
        UD2 := unsigned(DATA2);
        case FUNC is
            when ADD     =>
                O <= std_logic_vector(UD1 + UD2);
            when SUB     =>
                O <= std_logic_vector(UD1 - UD2);
            when MULT    =>
                O <= std_logic_vector(UD1(LOW_HALF) * (UD2(LOW_HALF)));
            when BITAND  =>
                O <= DATA1 and DATA2;
            when BITOR   =>
                O <= DATA1 or DATA2;
            when BITXOR  =>
                O <= DATA1 xor DATA2;
            when FUNCLSL =>
                O <= DATA1(N-2 downto 0) & '0';
            when FUNCLSR =>
                O <= '0' & DATA1(N-1 downto 1);
            when FUNCRL  =>
                O <= DATA1(N-2 downto 0) & DATA1(N-1);
            when FUNCRR  =>
                O <= DATA1(0) & DATA1(N-1 downto 1);
            when others  => null;
        end case;
    end process;
end behavioral;

configuration cfg_alu_behavioral of alu is
    for behavioral
    end for;
end configuration;
