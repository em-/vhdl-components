library ieee;
use ieee.std_logic_1164.all;

entity tb_and2 is
end tb_and2;

architecture test of tb_and2 is
    signal A, B, O: std_logic;

    component and2 port (
        A, B: in  std_logic;
        O:    out std_logic);
    end component;
begin
    U: and2 port map (A, B, O);

    process
        constant inputA:    std_logic_vector (0 to 3) := "0011";
        constant inputB:    std_logic_vector (0 to 3) := "0101";
        constant reference: std_logic_vector (0 to 3) := "0001";
    begin
        for i in reference'Range loop
            A <= inputA(i);
            B <= inputB(i);

            wait for 1 ns;

            assert O = reference(i);
        end loop;
        wait;
    end process;
end test;
