library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mac is
    generic (N: integer := 8);
    port (CLK, RST:   in  std_logic;
          EN:         in  std_logic;
          A, B:       in  std_logic_vector (N-1 downto 0);
          ACCUMULATE: in  std_logic;
          O:          out std_logic_vector (2*N-1 downto 0));
end mac;

architecture behavioral of mac is
begin
    process (RST, CLK)
        variable feedback: unsigned (O'Range);
    begin
        if RST = '0' then
            feedback := (others => '0');
        elsif rising_edge(CLK) and EN = '0' then
            if ACCUMULATE = '0' then
                feedback := unsigned(A) * unsigned(B);
            else
                feedback := unsigned(A) * feedback(B'Range);
            end if;
        end if;

        O <= std_logic_vector(feedback);
    end process;
end behavioral;

architecture structural of mac is
    signal OUT_MUX:  std_logic_vector (N-1 downto 0);
    signal OUT_MULT: std_logic_vector (2*N-1 downto 0);
    signal OUT_REG:  std_logic_vector (2*N-1 downto 0);

    component mux21
        generic (N: integer := 8);
        port (A, B: in  std_logic_vector (N-1 downto 0);
              SEL:  in  std_logic;
              O:    out std_logic_vector (N-1 downto 0) );
    end component;

    component multiplier
        generic (N: integer := 8);
        port (A, B:     in  std_logic_vector (N-1 downto 0);
              O:        out std_logic_vector (2*N-1 downto 0));
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

    input: mux21
            generic map (N)
            port map (B, OUT_REG(B'Range), ACCUMULATE, OUT_MUX);

    mult: multiplier
            generic map (N => N)
            port map (A, OUT_MUX, OUT_MULT);

    data: reg
            generic map (2*N)
            port map (CLK, RST, EN, OUT_MULT, OUT_REG);
end structural;


configuration cfg_mac_behavioral of mac is
    for behavioral
    end for;
end cfg_mac_behavioral;

configuration cfg_mac_structural of mac is
    for structural
    end for;
end cfg_mac_structural;
