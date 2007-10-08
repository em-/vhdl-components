library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.alu_operations.all;

entity tb_alu is
end tb_alu;

architecture test of tb_alu is
    constant N: integer := 16;

    component alu
        generic (N : integer := 8);
        port (FUNC:         in  ALU_OPERATION;
              DATA1, DATA2: in  std_logic_vector(N-1 downto 0);
              O:            out std_logic_vector(N-1 downto 0));
    end component;

    subtype LOW_HALF is natural range (N/2)-1 downto 0;
    signal OPERATION: ALU_OPERATION;
    signal OP1, OP2: unsigned(N-1 downto 0);
    signal RESULT:   std_logic_vector(N-1 downto 0);
begin
    u: alu
        generic map (N)
        port map (OPERATION,
                  std_logic_vector(OP1),
                  std_logic_vector(OP2),
                  RESULT);

        OP1 <= "0000000000110101";
        OP2 <= "0000000000010110";

        process
        begin
            OPERATION <= ADD;
            wait for 1 ns;
            assert unsigned(RESULT) = OP1 + OP2;

            OPERATION <= SUB;
            wait for 1 ns;
            assert unsigned(RESULT) = OP1 - OP2;

            OPERATION <= MULT;
            wait for 1 ns;
            assert unsigned(RESULT) = OP1(LOW_HALF) * OP2(LOW_HALF);

            OPERATION <= BITAND;
            wait for 1 ns;
            assert RESULT = std_logic_vector(OP1 and OP2);

            OPERATION <= BITOR;
            wait for 1 ns;
            assert RESULT = std_logic_vector(OP1 or OP2);

            OPERATION <= BITXOR;
            wait for 1 ns;
            assert RESULT = std_logic_vector(OP1 xor OP2);

            OPERATION <= FUNCRL;
            wait for 1 ns;
            assert RESULT = std_logic_vector(OP1 rol 1);

            OPERATION <= FUNCRR;
            wait for 1 ns;
            assert RESULT = std_logic_vector(OP1 ror 1);

            OPERATION <= FUNCLSL;
            wait for 1 ns;
            assert RESULT = std_logic_vector(OP1 sll 1);

            OPERATION <= FUNCLSR;
            wait for 1 ns;
            assert RESULT = std_logic_vector(OP1 srl 1);

            wait;
        end process;
end test;

configuration tb_alu_behavioral of tb_alu is
    for test
        for all: alu
            use configuration work.cfg_alu_behavioral;
        end for;
    end for;
end tb_alu_behavioral;
