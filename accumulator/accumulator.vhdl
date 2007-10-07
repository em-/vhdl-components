library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity accumulator is
    generic (N: integer := 8);
    port (CLK, RST:   in  std_logic;
          EN:         in  std_logic;
          A, B:       in  std_logic_vector (N-1 downto 0);
          ACCUMULATE: in  std_logic;
          O:          out std_logic_vector (N-1 downto 0));
end accumulator;

architecture behavioral of accumulator is
begin
    process (RST, CLK)
        variable feedback: unsigned (O'Range);
    begin
        if RST = '0' then
            feedback := (others => '0');
        elsif CLK = '1' and CLK'event and EN = '0' then
            if ACCUMULATE = '0' then
                feedback := unsigned(A) + unsigned(B);
            else
                feedback := unsigned(A) + feedback;
            end if;
        end if;

        O <= std_logic_vector(feedback);
    end process;
end behavioral;

architecture structural of accumulator is
    signal OUT_MUX:  std_logic_vector (N-1 downto 0);
    signal OUT_ADD:  std_logic_vector (N-1 downto 0);
    signal OUT_REG:  std_logic_vector (N-1 downto 0);

    component mux21
        generic (N: integer := 8);
        port (A, B: in  std_logic_vector (N-1 downto 0);
              SEL:  in  std_logic;
              O:    out std_logic_vector (N-1 downto 0) );
    end component;

    component rca
        generic (N: integer := 8);
        port (A, B: in  std_logic_vector (N-1 downto 0);
              Ci:   in  std_logic;
              S:    out std_logic_vector (N-1 downto 0);
              Co:   out std_logic);
    end component;

    component reg
        generic (N: integer := 8);
        port (CLK, RST:  in  std_logic;
              EN:        in  std_logic;
              A:         in  std_logic_vector (N-1 downto 0);
              O:         out std_logic_vector (N-1 downto 0));
    end component;
begin
    O <= OUT_REG after 0 ns;

    input: mux21
            generic map (N)
            port map (B, OUT_REG, ACCUMULATE, OUT_MUX);

    adder: rca
            generic map (N => N)
            port map (A, OUT_MUX, '0', OUT_ADD);

    data: reg
            generic map (N)
            port map (CLK, RST, EN, OUT_ADD, OUT_REG);
end structural;


configuration cfg_accumulator_behavioral of accumulator is
    for behavioral
    end for;
end cfg_accumulator_behavioral;

configuration cfg_accumulator_structural of accumulator is
    for structural
    end for;
end cfg_accumulator_structural;
