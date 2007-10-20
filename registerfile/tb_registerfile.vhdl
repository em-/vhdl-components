library ieee;
use ieee.std_logic_1164.all;

entity tb_registerfile is
end tb_registerfile;

architecture test of tb_registerfile is
    constant NBIT:       integer := 64;
    constant NREG:       integer := 5;
    constant clk_period: time    := 0.5 ns; -- Clock period (2 GHz)

    component registerfile
        generic (N:    integer;
                 NREG: integer);
        port (CLK, RST: in  std_logic;
              EN, WR:   in  std_logic;
              RD1, RD2: in  std_logic;
              ADDR_WR:  in  std_logic_vector (NREG-1 downto 0);
              ADDR_RD1: in  std_logic_vector (NREG-1 downto 0);
              ADDR_RD2: in  std_logic_vector (NREG-1 downto 0);
              DATA_IN:  in  std_logic_vector (N-1 downto 0);
              OUT1:     out std_logic_vector (N-1 downto 0);
              OUT2:     out std_logic_vector (N-1 downto 0));
    end component;

    signal CLK, RST: std_logic := '0';
    signal EN, WR:   std_logic;
    signal RD1, RD2: std_logic;
    signal ADDR_WR:  std_logic_vector (NREG-1 downto 0);
    signal ADDR_RD1: std_logic_vector (NREG-1 downto 0);
    signal ADDR_RD2: std_logic_vector (NREG-1 downto 0);
    signal DATA_IN:  std_logic_vector (NBIT-1 downto 0);
    signal OUT1:     std_logic_vector (NBIT-1 downto 0);
    signal OUT2:     std_logic_vector (NBIT-1 downto 0);
begin
    u: registerfile
        generic map (NBIT, NREG)
        port map (CLK, RST, EN, WR, RD1, RD2,
                  ADDR_WR, ADDR_RD1, ADDR_RD2,
                  DATA_IN, OUT1, OUT2);

    process
    begin
        for i in 0 to 42 loop
            CLK <= '1', '0' after clk_period/2;
            wait for clk_period;
        end loop;
        wait;
    end process;

    RST <= '1', '0' after 4 ns;
    EN  <= '0', '1' after 3 ns, '0' after 14 ns, '1' after 15 ns;
    WR  <= '0', '1' after 6 ns, '0' after 7 ns,
                '1' after 10 ns, '0' after 20 ns;
    RD1 <= '1', '0' after 5 ns, '1' after 8 ns,  '0' after 20 ns;
    RD2 <= '0', '1' after 17 ns;
    ADDR_WR  <= "10110", "01000" after 9 ns;
    ADDR_RD1 <= "10110", "01000" after 11 ns;
    ADDR_RD2 <= "11100", "01000" after 9 ns;
    DATA_IN <= (0 => '1', others => '0'),
               (0 => '0', others => '1') after 10 ns;

    process
        variable reference: std_logic_vector(OUT1'Range);
    begin
        wait for 1 ns;
        reference := (others => 'U');
        assert OUT1 = reference;
        assert OUT2 = reference;

        wait for 4 ns; -- 5 ns
        reference := (others => '0');
        assert OUT1 = reference;

        wait for 4 ns; -- 9 ns
        reference := (0 => '1', others => '0');
        assert OUT1 = reference;

        wait for 9 ns; -- 18 ns
        reference := (0 => '0', others => '1');
        assert OUT2 = reference;
        wait;
    end process;
end test;

configuration tb_registerfile_behavioral of tb_registerfile is
  for test
      for all: registerfile
        use configuration work.cfg_registerfile_behavioral;
      end for;
  end for;
end tb_registerfile_behavioral;
