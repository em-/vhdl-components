library ieee; 
use ieee.std_logic_1164.all; 

entity counter is
    generic (N: integer := 8);
    port (CLK, RST: in    std_logic;
          EN:       in    std_logic;
          S:        inout std_logic_vector (N-1 downto 0);
          OWFL:     out   std_logic
    );
end counter;

architecture structural of counter is
    component ha
        port (A, B: in  std_logic;
              S:    out std_logic;
              Co:   out std_logic);
    end component;

    component fd
        port (CLK, RST: in  std_logic;
              EN:       in  std_logic;
              D:        in  std_logic;
              Q:        out std_logic);
    end component;

    signal carry: std_logic_vector (N downto 0);
    signal sum: std_logic_vector (N-1 downto 0);
begin
    carry(0) <= '1';
    OWFL <= carry(N);

    count: for i in N-1 downto 0 generate
        ha_i: ha port map (S(i), carry(i), sum(i), carry(i+1));
        fd_i: fd port map (CLK, RST, EN, sum(i), S(i));
    end generate;
end structural;
