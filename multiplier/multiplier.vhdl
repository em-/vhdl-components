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

    O(0) <= tAND(0)(0);

    ha00: ha
    port map (tAND(0)(1), tAND(1)(0), S(0)(0), C(0)(0));
    fa01: fa
    port map (tAND(0)(2), tAND(1)(1), C(0)(0), S(0)(1), C(0)(1));
    fa02: fa
    port map (tAND(0)(3), tAND(1)(2), C(0)(1), S(0)(2), C(0)(2));
    ha03: ha
    port map (tAND(1)(3), C(0)(2), S(0)(3), C(0)(3));

    O(1) <= S(0)(0);

    ha10: ha
    port map (S(0)(1), tAND(2)(0), S(1)(0), C(1)(0));
    fa11: fa
    port map (S(0)(2), tAND(2)(1), C(1)(0), S(1)(1), C(1)(1));
    fa12: fa
    port map (S(0)(3), tAND(2)(2), C(1)(1), S(1)(2), C(1)(2));
    fa13: fa
    port map (C(0)(3), tAND(2)(3), C(1)(2), S(1)(3), C(1)(3));

    O(2) <= S(1)(0);

    ha20: ha
    port map (S(1)(1), tAND(3)(0), S(2)(0), C(2)(0));
    fa21: fa
    port map (S(1)(2), tAND(3)(1), C(2)(0), S(2)(1), C(2)(1));
    fa22: fa
    port map (S(1)(3), tAND(3)(2), C(2)(1), S(2)(2), C(2)(2));
    fa23: fa
    port map (C(1)(3), tAND(3)(3), C(2)(2), S(2)(3), C(2)(3));

    O(6 downto 3) <= S(2);
    O(7) <= C(2)(3);
end structural;

configuration cfg_multiplier_behavioral of multiplier is
    for behavioral
    end for;
end cfg_multiplier_behavioral;

configuration cfg_multiplier_structural of multiplier is
    for structural
    end for;
end cfg_multiplier_structural;
