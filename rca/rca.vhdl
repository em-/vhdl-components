library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rca is
    generic (N: integer := 8;
             DELAY_S, DELAY_Co: time := 0 ns);

    port (A, B: in  std_logic_vector (N-1 downto 0);
          Ci:   in  std_logic;
          S:    out std_logic_vector (N-1 downto 0);
          Co:   out std_logic);
end rca;

architecture behavioral of rca is
begin
    process (A, B, Ci)
        variable sum: unsigned (N downto 0);
        variable unsigned_A, unsigned_B, unsigned_Ci: unsigned (sum'Range);
    begin
        unsigned_A := '0' & unsigned(A);
        unsigned_B := '0' & unsigned(B);
        unsigned_Ci := (0 => Ci, others => '0');

        sum := unsigned_A + unsigned_B + unsigned_Ci;

        S  <= std_logic_vector (sum(N-1 downto 0)) after DELAY_S;
        Co <= std_logic (sum (N)) after DELAY_Co;
    end process;
end behavioral;

architecture structural of rca is
    signal carry_propagate: std_logic_vector (N downto 0);
    component fa is
        generic (DELAY_S, DELAY_Co: time := 0 ns);
        port (A, B: in std_logic;
              Ci:   in  std_logic;
              S:    out std_logic;
              Co:   out std_logic);
    end component;
begin
    carry_propagate(0) <= Ci;

    fa_array: for i in 0 to N-1 generate
        fa_i: fa
            generic map (DELAY_S, DELAY_Co)
            port map (A(i), B(i), carry_propagate(i),
                      S(i), carry_propagate(i+1));
    end generate;

    Co <= carry_propagate(N);
end structural;


configuration cfg_rca_behavioral of rca is
    for behavioral
    end for;
end cfg_rca_behavioral;

configuration cfg_rca_structural of rca is
    for structural
    end for;
end cfg_rca_structural;
