library ieee; 
use ieee.std_logic_1164.all; 

entity accumulator is
    generic (N: integer := 8);
    port (CLK, RST:   in    std_logic;
          EN:         in    std_logic;
          A, B:       in    std_logic_vector (N-1 downto 0);
          ACCUMULATE: in    std_logic;
          O:          inout std_logic_vector (N-1 downto 0));
end accumulator;


architecture structural of accumulator is
    signal OUT_MUX:  std_logic_vector (N-1 downto 0);
    signal OUT_ADD:  std_logic_vector (N-1 downto 0);

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
    input: mux21
            generic map (N)
            port map (B, O, ACCUMULATE, OUT_MUX);

    adder: rca
            generic map (N => N)
            port map (A, OUT_MUX, '0', OUT_ADD);

    data: reg
            generic map (N)
            port map (CLK, RST, EN, OUT_ADD, O);
end structural;
