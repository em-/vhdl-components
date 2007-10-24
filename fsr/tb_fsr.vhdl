library std;
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- synopsys only

entity tb_fsr is
end tb_fsr;

architecture test of tb_fsr is
    signal CLK, RST: std_logic := '0';
    signal S, R: std_logic;
    signal Q: std_logic;
    signal counter: integer := -1;

    component fsr port (
        CLK, RST: in  std_logic;
        S, R:     in  std_logic;
        Q:        out std_logic);
    end component;

    signal finished: boolean := false;
begin
    U: fsr port map (CLK, RST, S, R, Q);

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
        variable testRST, testS, testR, testQ: std_logic;
        file test_file: text is in "fsr/tb_fsr.test";

        variable l: line;
        variable i: integer;
        variable good: boolean;
    begin
        wait on counter;

        while not endfile(test_file) loop
            readline(test_file, l);

            -- read the time from the beginning of the line
            -- skip the line if it doesn't start with an integer
            read(l, i, good => good);
            next when not good;

            read(l, testRST);
            read(l, testS);
            read(l, testR);

            read(l, testQ);

            wait on counter until counter = i;

            RST <= testRST;
            S <= testS;
            R <= testR;

            assert Q = testQ report "Mismatch on output Q";
        end loop;

        finished <= true;
        wait;
    end process;
end test;

configuration tb_fsr_behavioral_async of tb_fsr is
    for test
        for all: fsr
            use configuration work.cfg_fsr_behavioral_async;
        end for;
    end for;
end tb_fsr_behavioral_async;

configuration tb_fsr_behavioral_sync of tb_fsr is
    for test
        for all: fsr
            use configuration work.cfg_fsr_behavioral_sync;
        end for;
    end for;
end tb_fsr_behavioral_sync;
