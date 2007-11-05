library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mac is
    generic (N: integer := 8);
    port (CLK, RST:   in  std_logic;
          EN:         in  std_logic;
          A, B:       in  std_logic_vector (N-1 downto 0);
          O:          out std_logic_vector (2*N-1 downto 0));
end mac;

architecture behavioral of mac is
begin
    process (RST, CLK)
        variable feedback, prod: unsigned (O'Range);
    begin
        if RST = '1' then
            feedback := (others => '0');
        elsif rising_edge(CLK) and EN = '1' then
            prod := unsigned(A) * unsigned(B);
            feedback := feedback + prod;
        end if;

        O <= std_logic_vector(feedback);
    end process;
end behavioral;

architecture structural of mac is
    signal OUT_MULT: std_logic_vector (2*N-1 downto 0);
    signal OUT_ADD:  std_logic_vector (2*N-1 downto 0);
    signal OUT_REG:  std_logic_vector (2*N-1 downto 0);

    component multiplier
        generic (N: integer := 8);
        port (A, B:     in  std_logic_vector (N-1 downto 0);
              O:        out std_logic_vector (2*N-1 downto 0));
    end component;

    component rca
        generic (N: integer;
                 DELAY_S, DELAY_Co: time := 0 ns);
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
    O <= OUT_REG;

    mult: multiplier
            generic map (N => N)
            port map (A, B, OUT_MULT);

    add: rca
            generic map (2*N)
            port map (OUT_MULT, OUT_REG, '0', OUT_ADD);

    data: reg
            generic map (2*N)
            port map (CLK, RST, EN, OUT_ADD, OUT_REG);
end structural;


configuration cfg_mac_behavioral of mac is
    for behavioral
    end for;
end cfg_mac_behavioral;

configuration cfg_mac_structural of mac is
    for structural
    end for;
end cfg_mac_structural;
