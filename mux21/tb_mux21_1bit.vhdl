library ieee;
use ieee.std_logic_1164.all;

entity tb_mux21_1bit is
end tb_mux21_1bit;

architecture test of tb_mux21_1bit is
    signal A, B, SEL, O: std_logic;

    component mux21_1bit port (
        A, B: in  std_logic;
        SEL:  in  std_logic;
        O:    out std_logic);
    end component;
begin
    U: mux21_1bit port map (A, B, SEL, O);

    process
        constant inputA:    std_logic_vector (0 to 7) := "00001111";
        constant inputB:    std_logic_vector (0 to 7) := "00110011";
        constant inputSEL:  std_logic_vector (0 to 7) := "01010101";
        constant reference: std_logic_vector (0 to 7) := "00011011";
    begin
        for i in reference'Range loop
            A   <= inputA(i);
            B   <= inputB(i);
            SEL <= inputSEL(i);

            wait for 1 ns;

            assert O = reference(i);
        end loop;
        wait;
    end process;
end test;


configuration tb_mux21_1bit_structural of tb_mux21_1bit is
   for test
      for all: mux21_1bit
         use configuration work.cfg_mux21_1bit_structural;
      end for;
   end for;
end tb_mux21_1bit_structural;

configuration tb_mux21_1bit_behavioral of tb_mux21_1bit is
   for test
      for all: mux21_1bit
         use configuration work.cfg_mux21_1bit_behavioral;
      end for;
   end for;
end tb_mux21_1bit_behavioral;
