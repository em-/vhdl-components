library ieee;

use ieee.std_logic_1164.all;

entity tb_iv is
end tb_iv;

architecture test of tb_iv is
    signal INPUT:  std_logic :='0';
    signal OUTPUT: std_logic;

    component iv
        port (I: in  std_logic;
              O: out std_logic);
    end component;
begin
    uiv: iv port map (INPUT, OUTPUT);

    INPUT <= '0' after 1 ns, '1' after 2 ns, '0' after 10 ns;

    process
    begin
        wait for 1.2 ns; -- account for the delay of the iv if present
        assert OUTPUT = '1';
        wait for 1 ns;
        assert OUTPUT = '0';
        wait for 8 ns;
        assert OUTPUT = '1';
        wait;
    end process;
end test;

configuration tb_iv_behavioral of tb_iv is
   for test
      for all: iv
         use configuration work.cfg_iv_behavioral;
      end for;
   end for;
end tb_iv_behavioral;

configuration tb_iv_behavioral_delay of tb_iv is
   for test
      for all: iv
         use configuration work.cfg_iv_behavioral_delay;
      end for;
   end for;
end tb_iv_behavioral_delay;
