library ieee; 
use ieee.std_logic_1164.all; 

entity mux21_1bit is
    port (A, B: in  std_logic;
          SEL:  in  std_logic;
          O:    out std_logic);
end mux21_1bit;

architecture behavioral of mux21_1bit is
begin
process (A, B, SEL)
begin
    if SEL = '0' then
        O <= A;
    else
        O <= B;
    end if;
end process;
end behavioral;

architecture logic of mux21_1bit is
begin
    O <= (A and (not SEL)) or (B and SEL);
end logic;

architecture structural of mux21_1bit is
    signal O1: std_logic;
    signal O2: std_logic;
    signal nSEL: std_logic;

    component nand2
        port (A, B: in  std_logic;
              O:    out std_logic);
    end component;

    component iv
        port (I:    in  std_logic;
              O:    out std_logic);
    end component;
begin
    Uiv: iv port map (SEL, nSEL);

    Unand1: nand2 port map (A, nSEL, O1);

    Unand2: nand2 port map (B, SEL, O2);

    Unand3: nand2 port map (O1, O2, O);
end structural;


configuration cfg_mux21_1bit_behavioral of mux21_1bit is
    for behavioral
    end for;
end cfg_mux21_1bit_behavioral;

configuration cfg_mux21_1bit_structural of mux21_1bit is
    for structural
        for all: iv
                use configuration work.cfg_iv_behavioral;
        end for;
        for all: nand2
                use configuration work.cfg_nand2_logic;
        end for;
    end for;
end cfg_mux21_1bit_structural;
