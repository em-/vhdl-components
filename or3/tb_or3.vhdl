library ieee;
use ieee.std_logic_1164.all;

entity tb_or3 is
end tb_or3;

architecture test of tb_or3 is
    signal A, B, C, O: std_logic;

    component or3 port (
        A, B, C: in  std_logic;
        O:       out std_logic);
    end component;
begin
    U: or3 port map (A, B, C, O);

    process
        constant inputA:    std_logic_vector (0 to 7) := "00001111";
        constant inputB:    std_logic_vector (0 to 7) := "00110011";
        constant inputC:    std_logic_vector (0 to 7) := "01010101";
        constant reference: std_logic_vector (0 to 7) := "01111111";
    begin
        for i in reference'Range loop
            A <= inputA(i);
            B <= inputB(i);
            C <= inputC(i);

            wait for 1 ns;

            assert O = reference(i);
        end loop;
        wait;
    end process;
end test;
