library ieee;
use ieee.std_logic_1164.all;

entity tb_exor is
end tb_exor;

architecture test of tb_exor is
    signal inputA: std_logic := '0';
    signal inputB: std_logic := '0';
    signal output: std_logic;

    component exor
        port (A, B: in  std_logic;
              O:    out std_logic);
    end component;
begin
    u: exor
        port map (inputA, inputB, output);

    inputA <= '0' after 1 ns, '1' after 2 ns,
              '0' after 10 ns, '1' after 12 ns,
              '0' after 12.05 ns, '1' after 13 ns,
              '0' after 13.11 ns;
    inputB <= '0' after 1 ns, '1' after 3 ns,
              '0' after 11 ns, '1' after 12 ns,
              '0' after 12.05 ns, '1' after 13 ns,
              '0' after 13.11 ns;

    process
    begin
        wait for 1.01 ns;
        assert output = '0';
        wait for 1 ns;
        assert output = '1';
        wait for 1 ns;
        assert output = '0';
        wait for 7 ns;
        assert output = '1';
        wait for 1 ns;
        assert output = '0';
        wait for 1 ns;
        assert output = '0';
        wait for 1 ns;
        assert output = '0';
        wait;
    end process;
end test;


configuration tb_exor_logic of tb_exor is
    for test
        for all: exor
            use configuration work.cfg_exor_logic;
        end for;
    end for;
end tb_exor_logic;

configuration tb_exor_logic_transport of tb_exor is
    for test
        for all: exor
            use configuration work.cfg_exor_logic_transport;
        end for;
    end for;
end tb_exor_logic_transport;

configuration tb_exor_behavioral of tb_exor is
    for test
        for all: exor
            use configuration work.cfg_exor_behavioral;
        end for;
    end for;
end tb_exor_behavioral;
