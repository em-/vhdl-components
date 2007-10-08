library std;
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- synopsys only

entity tb_mac is
end tb_mac;

architecture test of tb_mac is
    constant N:        integer := 3;

    signal CLK, RST:   std_logic := '0';
    signal EN:         std_logic;
    signal A, B:       std_logic_vector (N-1 downto 0);
    signal ACCUMULATE: std_logic;
    signal O:          std_logic_vector (2*N-1 downto 0);
    signal referenceO: std_logic_vector (O'Range);

    component mac
        generic (N: integer);
        port (CLK, RST:   in  std_logic;
              EN:         in  std_logic;
              A, B:       in  std_logic_vector (N-1 downto 0);
              ACCUMULATE: in  std_logic;
              O:          out std_logic_vector (2*N-1 downto 0));
    end component;

    signal clock_counter: integer := -1;
    signal finished: boolean := false;
begin
    U: mac
        generic map (N)
        port map (CLK, RST, EN, A, B, ACCUMULATE, O);

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

    check: postponed process(referenceO)
    begin
        assert O = referenceO report "Mismatch on output O";
    end process;

    test: process
        variable testRST, testEN, testACCUMULATE: std_logic;
        variable testA, testB: std_logic_vector(A'Range);
        variable testO: std_logic_vector(O'Range);
        file test_file: text is in "mac/tb_mac.test";

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
            read(l, testACCUMULATE);

            read(l, testA);
            read(l, testB);

            read(l, testO);

            wait on clock_counter until clock_counter = t;

            RST <= testRST;
            EN <= testEN;
            ACCUMULATE <= testACCUMULATE;
            A <= testA;
            B <= testB;

            referenceO <= testO;
        end loop;

        finished <= true;
        wait;
    end process;
end test;


configuration tb_mac_behavioral of tb_mac is
  for test
      for all: mac
          use configuration work.cfg_mac_behavioral;
      end for;
  end for;
end tb_mac_behavioral;

configuration tb_mac_structural of tb_mac is
  for test
      for all: mac
          use configuration work.cfg_mac_structural;
      end for;
  end for;
end tb_mac_structural;
