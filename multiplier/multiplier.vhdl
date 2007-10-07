library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity multiplier is
    generic (N: integer := 4);
    port (A, B:     in  std_logic_vector (N-1 downto 0);
          O:        out std_logic_vector (2*N-1 downto 0)
    );
end multiplier;

architecture behavioral of multiplier is
begin
    O <= std_logic_vector(unsigned(unsigned(A) * unsigned(B)));
end behavioral;


architecture structural of multiplier is
    component fa
        port (A, B: in std_logic;
              Ci:   in  std_logic;
              S:    out std_logic;
              Co:   out std_logic);
    end component;
    component ha
        port (A, B:  in  std_logic;
              S, Co: out std_logic);
    end component;
    component and2
        port (A, B: in  std_logic;
              O:    out std_logic);
    end component;

    type SignalVector is array (N-1 downto 0) of std_logic_vector(N-1 downto 0);
    signal tAND, S, C: SignalVector;
begin
    ands: for i in B'Range generate
        ands_i: for j in A'Range generate
            ands_ij: and2 port map (B(i), A(j), tAND(i)(j));
        end generate;
    end generate;

    S(0) <= tAND(0);
    C(0) <= (others => '0');

    row: for i in 1 to N-1 generate
    O(i-1) <= S(i-1)(0);

    ha00: ha
    port map (S(i-1)(1), tAND(i)(0), S(i)(0), C(i)(0));

    fas: for j in 1 to N-2 generate
    fas_ij: fa
    port map (S(i-1)(j+1), tAND(i)(j), C(i)(j-1), S(i)(j), C(i)(j));
    end generate;

    fa03: fa
    port map (C(i-1)(N-1), tAND(i)(N-1), C(i)(N-2), S(i)(N-1), C(i)(N-1));
    end generate;

    O(2*N-2 downto N-1) <= S(N-1);
    O(2*N-1) <= C(N-1)(N-1);
end structural;

configuration cfg_multiplier_behavioral of multiplier is
    for behavioral
    end for;
end cfg_multiplier_behavioral;

configuration cfg_multiplier_structural of multiplier is
    for structural
    end for;
end cfg_multiplier_structural;
