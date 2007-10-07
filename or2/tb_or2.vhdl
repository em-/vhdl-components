library std;
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- synopsys only

entity tb_or2 is
end tb_or2;

architecture test of tb_or2 is
    signal A: std_logic := '0';
    signal B: std_logic := '0';
    signal O: std_logic;

    component or2
        generic (DELAY: time);
        port (A, B: in  std_logic;
              O:    out std_logic);
    end component;
begin
    U: or2
        generic map (DELAY => 0.2 ns)
        port map (A, B, O);

    A <= '0' after 1 ns, '1' after 2 ns, '0' after 10 ns,
         '1' after 12 ns, '0' after 12.05 ns,
         '1' after 13 ns, '0' after 13.11 ns;
    B <= '0' after 1 ns, '1' after 3 ns, '0' after 11 ns,
         '1' after 12 ns, '0' after 12.05 ns,
         '1' after 13 ns, '0' after 13.11 ns;

    process
    begin
        wait for 1.201 ns;
        assert O = '0';
        wait for 1 ns; -- 2.201 ns
        assert O = '1';
        wait for 1 ns; -- 3.201 ns
        assert O = '1';
        wait for 7 ns; -- 10.201 ns
        assert O = '1';
        wait for 1 ns; -- 11.201 ns
        assert O = '0';
        wait for 1 ns; -- 12.201 ns
        -- '1' if delay model is transport, '0' otherwise
        wait for 0.05 ns; -- 12.251 ns
        assert O = '0';
        wait for 0.95 ns; -- 13.201 ns
        -- '1' if delay model is transport, '0' otherwise
        wait for 0.11 ns; -- 13.311 ns
        assert O = '0';
        wait;
    end process;
end test;


configuration tb_or2_logic of tb_or2 is
   for test
      for all: or2
         use configuration work.cfg_or2_logic;
      end for;
   end for;
end tb_or2_logic;

configuration tb_or2_logic_transport of tb_or2 is
   for test
      for all: or2
         use configuration work.cfg_or2_logic_transport;
      end for;
   end for;
end tb_or2_logic_transport;

configuration tb_or2_behavioral of tb_or2 is
   for test
      for all: or2
         use configuration work.cfg_or2_behavioral;
      end for;
   end for;
end tb_or2_behavioral;
