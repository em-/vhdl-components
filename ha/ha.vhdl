library ieee;
use ieee.std_logic_1164.all;

entity ha is
    generic (DELAY_S, DELAY_Co: time := 0 ns);
    port (A, B: in  std_logic;
          S:    out std_logic;
          Co:   out std_logic);
end ha;

architecture logic of ha is
begin
    S <= A xor B after DELAY_S;
    Co <= A and B after DELAY_Co;
end logic;

architecture structural of ha is
    signal AN, BN, ANB, ABN, NAB: std_logic;

    component nand2
        generic (DELAY: time := 0 ns);
        port (A, B: in  std_logic;
              O:    out std_logic);
    end component;

    component iv
        port (I: in  std_logic;
              O: out std_logic);
    end component;
begin
    Uiv1: iv port map (A, AN);
    Uiv2: iv port map (B, BN);

    Unand1: nand2 port map (AN, B, ANB);
    Unand2: nand2 port map (A, BN, ABN);

    Unand3: nand2 port map (ANB, ABN, S);

    Unand4: nand2 port map (A, B, NAB);
    Uiv3: iv port map (NAB, Co);
end structural;

configuration cfg_ha_logic of ha is
    for logic
    end for;
end cfg_ha_logic;

configuration cfg_ha_structural of ha is
    for structural
    end for;
end cfg_ha_structural;
