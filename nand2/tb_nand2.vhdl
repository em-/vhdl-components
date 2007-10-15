library ieee;
use ieee.std_logic_1164.all;

entity tb_nand2 is
end tb_nand2;

architecture test of tb_nand2 is
    signal input1: std_logic := '0';
    signal input2: std_logic := '0';
    signal output: std_logic;

    component nand2
        generic (DELAY: time := 0 ns);
        port (A,B: in  std_logic;
              O:   out std_logic);
    end component;
begin
    U: nand2
        generic map (DELAY => 0.2 ns)
        port map (input1, input2, output);

    input1 <= '0' after 1 ns, '1' after 2 ns, '0' after 10 ns,
              '1' after 12 ns, '0' after 12.05 ns,
              '1' after 13 ns, '0' after 13.11 ns;
    input2 <= '0' after 1 ns, '1' after 3 ns, '0' after 11 ns,
              '1' after 12 ns, '0' after 12.05 ns,
              '1' after 13 ns, '0' after 13.11 ns;

    process
    begin
        wait for 1.201 ns;
        assert output = '1';
        wait for 1 ns; -- 2.201 ns
        assert output = '1';
        wait for 1 ns; -- 3.201 ns
        assert output = '0';
        wait for 7 ns; -- 10.201 ns
        assert output = '1';
        wait for 1 ns; -- 11.201 ns
        assert output = '1';
        wait for 1 ns; -- 12.201 ns
        -- '0' if delay model is transport, '1' otherwise
        wait for 0.05 ns; -- 12.251 ns
        assert output = '1';
        wait for 0.95 ns; -- 13.201 ns;
        -- '0' if delay model is transport, '1' otherwise
        wait for 0.11 ns; -- 13.311 ns;
        assert output = '1';
        wait;
    end process;
end test;


configuration tb_nand2_logic of tb_nand2 is
   for test
      for all: nand2
         use configuration work.cfg_nand2_logic;
      end for;
   end for;
end tb_nand2_logic;

configuration tb_nand2_logic_transport of tb_nand2 is
   for test
      for all: nand2
         use configuration work.cfg_nand2_logic_transport;
      end for;
   end for;
end tb_nand2_logic_transport;

configuration tb_nand2_behavioral of tb_nand2 is
   for test
      for all: nand2
         use configuration work.cfg_nand2_behavioral;
      end for;
   end for;
end tb_nand2_behavioral;
