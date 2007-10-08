library std;
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- synopsys only

entity tb_fjk is
end tb_fjk;

architecture test of tb_fjk is
    signal CLK, RST: std_logic := '0';
    signal J, K: std_logic;
    signal Q: std_logic;
    signal counter: integer := -1;

    component fjk port (
        CLK, RST: in  std_logic;
        J, K:     in  std_logic;
        Q:        out std_logic);
    end component;

    signal finished: boolean := false;
begin
    U: fjk port map (CLK, RST, J, K, Q);

    clock: process
    begin
        CLK <= not CLK;
        if finished then wait; end if;
        wait for 0.5 ns;
    end process;

    count: process(CLK)
    begin
        if rising_edge(CLK) then
            counter <= counter + 1;
        end if;
    end process;

    test: process
        variable testRST, testJ, testK, testQ: std_logic;
        file test_file: text is in "fjk/tb_fjk.test";

        variable l: line;
        variable i: integer;
        variable good: boolean;
        variable space: character;
    begin
        wait on counter;

        while not endfile(test_file) loop
            readline(test_file, l);

            -- read the time from the beginning of the line
            -- skip the line if it doesn't start with an integer
            read(l, i, good => good);
            next when not good;

            read(l, space);

            read(l, testRST);
            read(l, testJ);
            read(l, testK);

            read(l, space);

            read(l, testQ);

            wait on counter until counter = i;

            RST <= testRST;
            J <= testJ;
            K <= testK;

            assert Q = testQ report "Mismatch on output Q";
        end loop;

        finished <= true;
        wait;
    end process;
end test;

configuration tb_fjk_behavioral_async of tb_fjk is
    for test
        for all: fjk
            use configuration work.cfg_fjk_behavioral_async;
        end for;
    end for;
end tb_fjk_behavioral_async;

configuration tb_fjk_behavioral_sync of tb_fjk is
    for test
        for all: fjk
            use configuration work.cfg_fjk_behavioral_sync;
        end for;
    end for;
end tb_fjk_behavioral_sync;
