library std;
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- synopsys only

entity tb_latch is
end tb_latch;

architecture test of tb_latch is
    signal CLK: std_logic := '0';
    signal RST: std_logic := '1';
    signal EN: std_logic;
    signal A, O: std_logic_vector(2 downto 0);
    signal counter: integer := -1;

    component latch
        generic (N: integer := 3);
        port (
            CLK, RST: in  std_logic;
            EN:       in  std_logic;
            A:        in  std_logic_vector(N-1 downto 0);
            O:        out std_logic_vector(N-1 downto 0));
    end component;

    signal finished: boolean := false;
begin
    U: latch port map (CLK, RST, EN, A, O);

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
        variable testRST, testEN: std_logic;
        variable testA, testO: std_logic_vector(2 downto 0);
        file test_file: text is in "latch/tb_latch.test";

        variable l: line;
        variable t: integer;
        variable good: boolean;
    begin
        wait on counter;

        while not endfile(test_file) loop
            readline(test_file, l);

            -- read the time from the beginning of the line
            -- skip the line if it doesn't start with an integer
            read(l, t, good => good);
            next when not good;

            read(l, testRST);
            read(l, testEN);
            read(l, testA);

            read(l, testO);

            wait on counter until counter = t;

            RST <= testRST;
            EN <= testEN;
            A <= testA;

            assert O = testO report "Mismatch on output O";
        end loop;

        finished <= true;
        wait;
    end process;
end test;
