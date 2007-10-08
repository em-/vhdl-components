library std;
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- synopsys only

entity tb_comparator is
end tb_comparator;

architecture test of tb_comparator is
    signal A, B: std_logic_vector(2 downto 0);
    signal O: std_logic_vector (1 downto 0);

    component comparator
        generic(N: integer := 3);
        port(A, B: in  std_logic_vector (N-1 downto 0);
             O:    out std_logic_vector (1 downto 0));
    end component;
begin
    U: comparator port map (A, B, O);

    test: process
        variable testA, testB: std_logic_vector (2 downto 0);
        variable testO: std_logic_vector (1 downto 0);
        file test_file: text is in "comparator/tb_comparator.test";

        variable l: line;
        variable t: integer;
        variable good: boolean;
    begin
        while not endfile(test_file) loop
            readline(test_file, l);

            -- read the time from the beginning of the line
            -- skip the line if it doesn't start with an integer
            read(l, t, good => good);
            next when not good;

            read(l, testA);
            read(l, testB);

            read(l, testO);

            A <= testA;
            B <= testB;

            wait for t * 1 ns - now;

            assert O = testO report "Mismatch on output O";
        end loop;

        wait;
    end process;
end test;
