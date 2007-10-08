library std;
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- synopsys only

entity tb_fd_en is
end tb_fd_en;

architecture test of tb_fd_en is
    signal CLK, RST: std_logic := '0';
    signal EN, D: std_logic;
    signal Q: std_logic;
    signal counter: integer := -1;

    component fd_en port (
        CLK, RST: in  std_logic;
        EN:       in  std_logic;
        D:        in  std_logic;
        Q:        out std_logic);
    end component;

    signal finished: boolean := false;
begin
    U: fd_en port map (CLK, RST, EN, D, Q);

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
        variable testRST, testEN, testD, testQ: std_logic;
        file test_file: text is in "fd_en/tb_fd_en.test";

        variable l: line;
        variable t: integer;
        variable good: boolean;
        variable space: character;
    begin
        wait on counter;

        while not endfile(test_file) loop
            readline(test_file, l);

            -- read the time from the beginning of the line
            -- skip the line if it doesn't start with an integer
            read(l, t, good => good);
            next when not good;

            read(l, space);

            read(l, testRST);
            read(l, testEN);
            read(l, testD);

            read(l, space);

            read(l, testQ);

            wait on counter until counter = t;

            RST <= testRST;
            EN <= testEN;
            D <= testD;

            assert Q = testQ report "Mismatch on output Q";
        end loop;

        finished <= true;
        wait;
    end process;
end test;
