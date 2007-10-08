library std;
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- synopsys only

entity tb_ha is
end tb_ha;

architecture test of tb_ha is
    signal A: std_logic := '0';
    signal B: std_logic := '0';
    signal S: std_logic := '0';
    signal Co: std_logic;

    component ha port (
        A, B: in std_logic;
        S, Co: out std_logic);
    end component;
begin
    U: ha port map (A, B, S, Co);

    test: process
        variable testA, testB, testS, testCo: std_logic;
        file test_file: text is in "ha/tb_ha.test";

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

            read(l, testA);  -- read A value
            read(l, testB);  -- read B value
            read(l, testS);  -- read C value
            read(l, testCo);  -- read O value

            A <= testA;
            B <= testB;
            S <= testS;
            Co <= testCo;

            wait for t * 1 ns - now;

            assert S = testS report "Mismatch on output S";
            assert Co = testCo report "Mismatch on output Co";
        end loop;

        wait;
    end process;
end test;
