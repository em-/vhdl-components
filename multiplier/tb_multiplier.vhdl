library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_multiplier is
end tb_multiplier;

architecture test of tb_multiplier is
    constant N: integer := 2;
    signal A, B: std_logic_vector (N-1 downto 0);
    signal O: std_logic_vector (2*N-1 downto 0);

    component multiplier
        generic (N: integer := N);
        port (A, B:     in  std_logic_vector (N-1 downto 0);
              O:        out std_logic_vector (2*N-1 downto 0));
    end component;
begin
    u: multiplier port map (A, B, O);

    process
        variable max: integer := 2**N - 1;
    begin
        for i in 0 to max loop
            for j in 0 to max loop
                A <= std_logic_vector(to_unsigned(i, A'Length));
                B <= std_logic_vector(to_unsigned(j, B'Length));
                wait for 1 ns;
                for k in O'Range loop
                assert O(k) = to_unsigned(i*j, O'Length)(k)
                    report "O(" & integer'Image(k) & ") is " & std_logic'Image(O(k)) &
                            " expected " & std_logic'Image(to_unsigned(i*j, O'Length)(k));
                end loop;
                assert to_integer(unsigned(O)) = i*j
                    report "expected " & integer'Image(i) & "*" & integer'Image(j) &
                           "=" & integer'Image(i*j) &
                           " got " & integer'Image(to_integer(unsigned(O)));
            end loop;
        end loop;
        wait;
    end process;
end test;


configuration tb_multiplier_behavioral of tb_multiplier is
   for test
      for all: multiplier
         use configuration work.cfg_multiplier_behavioral;
      end for;
   end for;
end tb_multiplier_behavioral;

configuration tb_multiplier_structural of tb_multiplier is
   for test
      for all: multiplier
         use configuration work.cfg_multiplier_structural;
      end for;
   end for;
end tb_multiplier_structural;
