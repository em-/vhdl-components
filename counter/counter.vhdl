library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity counter is
    generic (N: integer := 8);
    port (CLK, RST: in    std_logic;
          EN:       in    std_logic;
          S:        inout std_logic_vector (N-1 downto 0);
          OWFL:     out   std_logic
    );
end counter;

architecture behavioral of counter is
begin
    process (RST, CLK)
    begin
        if RST = '0' then
            S <= (others => '0');
            OWFL <= '0';
        elsif CLK'event and CLK = '1' and EN = '0' then
            OWFL <= '0';
            if S = (S'Range => '1') then
                OWFL <= '1';
            end if;
            S <= std_logic_vector(unsigned(S)+1);
        end if;
    end process;
end behavioral;

architecture structural of counter is
    component ha
        port (A, B: in  std_logic;
              S:    out std_logic;
              Co:   out std_logic);
    end component;

    component fd_en
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
        fd_en_i: fd_en port map (CLK, RST, EN, sum(i), S(i));
    end generate;
end structural;


configuration cfg_counter_behavioral of counter is
    for behavioral
    end for;
end cfg_counter_behavioral;

configuration cfg_counter_structural of counter is
    for structural
    end for;
end cfg_counter_structural;
