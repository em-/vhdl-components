library std;
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- synopsys only

entity tb_counter is
end tb_counter;

architecture test of tb_counter is
    signal CLK, RST: std_logic := '0';
    signal EN: std_logic;
    signal S, referenceS: std_logic_vector(2 downto 0);
    signal OFLW, referenceOFLW: std_logic;
    signal clock_counter: integer := -1;

    component counter
        generic (N: integer := 3);
        port (CLK, RST: in    std_logic;
              EN:       in    std_logic;
              S:        inout std_logic_vector (N-1 downto 0);
              OFLW:     out   std_logic
        );
    end component;

    signal finished: boolean := false;
begin
    U: counter port map (CLK, RST, EN, S, OFLW);

    clock: process
    begin
        CLK <= not CLK;
        if finished then wait; end if;
        wait for 0.5 ns;
    end process;

    count: process(CLK)
    begin
        if rising_edge(CLK) then
            clock_counter <= clock_counter + 1;
        end if;
    end process;

    checkS: postponed process(referenceS)
    begin
        assert S = referenceS report "Mismatch on output S";
    end process;

    checkOFLW: postponed process(referenceOFLW)
    begin
        assert OFLW = referenceOFLW report "Mismatch on output OFLW";
    end process;

    test: process
        variable testRST, testEN: std_logic;
        variable testS: std_logic_vector(2 downto 0);
        variable testOFLW: std_logic;
        file test_file: text is in "counter/tb_counter.test";

        variable l: line;
        variable t: integer;
        variable good: boolean;
    begin
        wait on clock_counter;

        while not endfile(test_file) loop
            readline(test_file, l);

            -- read the time from the beginning of the line
            -- skip the line if it doesn't start with an integer
            read(l, t, good => good);
            next when not good;

            read(l, testRST);
            read(l, testEN);

            read(l, testS);
            read(l, testOFLW);

            wait on clock_counter until clock_counter = t;

            RST <= testRST;
            EN <= testEN;

            referenceS <= testS;
            referenceOFLW <= testOFLW;
        end loop;

        finished <= true;
        wait;
    end process;
end test;


configuration tb_counter_behavioral of tb_counter is
  for test
      for all: counter
          use configuration work.cfg_counter_behavioral;
      end for;
  end for;
end tb_counter_behavioral;

configuration tb_counter_structural of tb_counter is
  for test
      for all: counter
          use configuration work.cfg_counter_structural;
      end for;
  end for;
end tb_counter_structural;
