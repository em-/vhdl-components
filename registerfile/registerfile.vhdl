library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerfile is
    generic (N:    integer := 64;
             NREG: integer := 8);
    port (CLK, RST: in  std_logic;
          EN, WR:   in  std_logic;
          RD1, RD2: in  std_logic;
          ADDR_WR:  in  std_logic_vector (NREG-1 downto 0);
          ADDR_RD1: in  std_logic_vector (NREG-1 downto 0);
          ADDR_RD2: in  std_logic_vector (NREG-1 downto 0);
          DATA_IN:  in  std_logic_vector (N-1 downto 0);
          OUT1:     out std_logic_vector (N-1 downto 0);
          OUT2:     out std_logic_vector (N-1 downto 0));
end registerfile;

architecture behavioral of registerfile is
    constant max_reg: integer := 2**NREG-1;
    type reg_array is array (max_reg downto 0)
                   of std_logic_vector (N-1 downto 0);
    signal REGISTERS: reg_array;
begin
    process (CLK, RST)
    begin
        if RST = '1' then
            OUT1 <= (others => '0');
            OUT2 <= (others => '0');
        elsif CLK'event and CLK = '1' and EN = '1' then
            if RD1 = '1' then
                OUT1 <= REGISTERS(to_integer(unsigned(ADDR_RD1)));
            end if;
            if RD2 = '1' then
                OUT2 <= REGISTERS(to_integer(unsigned(ADDR_RD2)));
            end if;
            if WR = '1' then
                REGISTERS(to_integer(unsigned(ADDR_WR))) <= DATA_IN;
            end if;
        end if;
    end process;
end behavioral;

configuration cfg_registerfile_behavioral of registerfile is
    for behavioral
    end for;
end cfg_registerfile_behavioral;
