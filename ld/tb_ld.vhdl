library ieee;
use ieee.std_logic_1164.all;

entity tb_ld is
end tb_ld;

architecture test of tb_ld is
    signal CLK, RST: std_logic := '0';
    signal D: std_logic;
    signal Q: std_logic;

    component ld port (
        CLK, RST: in  std_logic;
        D:        in  std_logic;
        Q:        out std_logic);
    end component;

    signal finished: boolean := false;
begin
    U: ld port map (CLK, RST, D, Q);

    clock: process
    begin
        CLK <= not CLK;
        if finished then wait; end if;
        wait for 0.5 ns;
    end process;

    RST <= '1' after 1 ns, '0' after 2 ns, '1' after 8 ns, '0' after 9 ns;
    D <= '1' after 1 ns, '0' after 3 ns, '1' after 4 ns, '0' after 5 ns,
         '1' after 6 ns, '0' after 12 ns;

    finished <= true after 12 ns;

    check: process
    begin
        wait for 1 ns; -- 1 ns
        assert Q = 'U';
        wait for 1 ns; -- 2 ns
        assert Q = '0';
        wait for 1 ns; -- 3 ns
        assert Q = '1';
        wait for 1 ns; -- 4 ns
        assert Q = '0';
        wait for 1 ns; -- 5 ns
        assert Q = '1';
        wait for 1 ns; -- 6 ns
        assert Q = '0';
        wait for 1 ns; -- 7 ns
        assert Q = '1';
        wait for 1 ns; -- 8 ns
        assert Q = '1';
        wait for 1 ns; -- 9 ns
        assert Q = '0';
        wait for 1 ns; -- 10 ns
        assert Q = '1';
        wait for 1 ns; -- 11 ns
        assert Q = '1';
        wait for 1 ns; -- 12 ns
        assert Q = '1';
        wait;
    end process;
end test;
