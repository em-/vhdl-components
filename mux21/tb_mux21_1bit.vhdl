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

    A <= '0' after 1 ns, '1' after 2 ns, '0' after 10 ns;
    B <= '0', '1' after 12 ns, '0' after 12.05 ns,
              '1' after 13 ns, '0' after 13.11 ns,
              '1' after 15 ns, '0' after 15.3 ns ;
    SEL <= '0' after 1 ns, '1' after 3 ns, '0' after 9 ns, '1' after 11 ns;

    check: postponed process
    begin
        wait for 1.2 ns;
        assert O = '0';
        wait for 1 ns; -- 2.2 ns
        assert O = '1';
        wait for 1 ns; -- 3.2 ns
        assert O = '0';
        wait for 6 ns; -- 9.2 ns
        assert O = '1';
        wait for 1 ns; -- 10.2 ns
        assert O = '0';
        wait for 5 ns; -- 15.2 ns
        assert O = '1';
        wait for 0.3 ns; -- 15.5 ns
        assert O = '0';
        wait;
    end process;
end test;


configuration tb_mux21_1bit_structural of tb_mux21_1bit is
   for test
      for all: mux21_1bit
         use entity work.mux21_1bit(structural);
         for structural
             for Unand3: nand2 use entity work.nand2
                 generic map (0.2 ns);
             end for;
             for Uiv: iv use entity work.iv(behavioral);
             end for;
         end for;
      end for;
   end for;
end tb_mux21_1bit_structural;

configuration tb_mux21_1bit_structural_transport of tb_mux21_1bit is
   for test
      for all: mux21_1bit
         use entity work.mux21_1bit(structural);
         for structural
             for Unand3: nand2 use entity work.nand2(logic_transport)
                 generic map (0.2 ns);
             end for;
             for Uiv: iv use entity work.iv(behavioral);
             end for;
         end for;
      end for;
   end for;
end tb_mux21_1bit_structural_transport;

configuration tb_mux21_1bit_logic of tb_mux21_1bit is
   for test
      for all: mux21_1bit
         use configuration work.cfg_mux21_1bit_logic;
      end for;
   end for;
end tb_mux21_1bit_logic;

configuration tb_mux21_1bit_behavioral of tb_mux21_1bit is
   for test
      for all: mux21_1bit
         use configuration work.cfg_mux21_1bit_behavioral;
      end for;
   end for;
end tb_mux21_1bit_behavioral;
