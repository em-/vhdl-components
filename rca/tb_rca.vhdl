library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_rca is
end tb_rca;

architecture test of tb_rca is
    constant N: integer := 2;
    signal A, B, S: std_logic_vector(N-1 downto 0);
    signal Ci, Co: std_logic;

    component rca
        generic (N: integer);
        port (A, B: in  std_logic_vector (N-1 downto 0);
              Ci:   in  std_logic;
              S:    out std_logic_vector (N-1 downto 0);
              Co:   out std_logic);
    end component;
begin
    u: rca generic map (N) port map (A, B, Ci, S, Co);

    test: process
        constant max: natural := 2**N - 1;
        variable sum: unsigned (S'Length downto 0);
    begin
        for i in 0 to max loop
            for j in 0 to max loop
                A <= std_logic_vector(to_unsigned(i, A'Length));
                B <= std_logic_vector(to_unsigned(j, B'Length));
                Ci <= '1';

                wait for 1 ns;

                assert to_integer(unsigned(Co & S)) = i+j+1
                    report "expected " & integer'Image(i) &
                        "+" & integer'Image(j) & "+1=" &
                        integer'Image(i+j+1) & " got " &
                        integer'Image(to_integer(unsigned(S))) &
                        " + " & std_logic'Image(Co);
            end loop;
        end loop;
        wait;
    end process;
end test;


configuration tb_rca_behavioral of tb_rca is
    for test
        for all: rca
            use configuration work.cfg_rca_behavioral;
        end for;
    end for;
end tb_rca_behavioral;

configuration tb_rca_structural of tb_rca is
    for test
        for all: rca
            use configuration work.cfg_rca_structural;
        end for;
    end for;
end tb_rca_structural;
