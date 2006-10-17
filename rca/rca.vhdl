library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity rca is
    generic (N: integer := 8);
    port (A, B: in  std_logic_vector (N-1 downto 0);
          Ci:   in  std_logic;
          S:    out std_logic_vector (N-1 downto 0);
          Co:   out std_logic);
end rca;

architecture structural of rca is
    signal carry_propagate: std_logic_vector (N downto 0);
    component fa is
        port (A, B: in std_logic;
              Ci:   in  std_logic;
              S:    out std_logic;
              Co:   out std_logic);
    end component; 
begin
    carry_propagate(0) <= Ci;

    fa_array: for i in 0 to N-1 generate 
        fa_i: fa port map (A(i), B(i), carry_propagate(i), 
                                 S(i), carry_propagate(i+1));
    end generate;

    Co <= carry_propagate(N);
end structural;
