library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    generic (N: integer := 8);
    port (CLK, RST: in    std_logic;
          EN:       in    std_logic;
          S:        out   std_logic_vector (N-1 downto 0);
          OFLW:     out   std_logic
    );
end counter;

architecture behavioral of counter is
begin
    process (RST, CLK)
        variable count: unsigned(S'Range);
    begin
        if RST = '0' then
            count := (others => '0');
            OFLW <= '0';
        elsif rising_edge(CLK) and EN = '0' then
            OFLW <= '0';
            if count = (count'Range => '1') then
                OFLW <= '1';
            end if;
            count := count + 1;
        end if;
        S <= std_logic_vector(count);
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
    signal sum, count: std_logic_vector (N-1 downto 0);
begin
    carry(0) <= '1';
    OFLW <= carry(N);

    count_array: for i in N-1 downto 0 generate
        ha_i: ha port map (count(i), carry(i), sum(i), carry(i+1));
        fd_en_i: fd_en port map (CLK, RST, EN, sum(i), count(i));
    end generate;

    S <= count;
end structural;


configuration cfg_counter_behavioral of counter is
    for behavioral
    end for;
end cfg_counter_behavioral;

configuration cfg_counter_structural of counter is
    for structural
    end for;
end cfg_counter_structural;
