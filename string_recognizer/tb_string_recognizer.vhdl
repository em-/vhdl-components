library ieee;
use ieee.std_logic_1164.all;

entity tb_string_recognizer is
end tb_string_recognizer;

architecture test of tb_string_recognizer is
    constant clk_period: time := 1 ns; -- Clock period (1 GHz)
    constant test_stream: 
            std_logic_vector (0 to 19) := "00110010001101001010";
    constant reference:
            std_logic_vector (0 to 19) := "U0000000100000010010";

    signal CLK: std_logic;
    signal RST: std_logic;
    signal INPUT: std_logic;
    signal OUTPUT: std_logic;

    component string_recognizer
        port (CLK, RST: in  std_logic;
              I:        in  std_logic;
              O:        out std_logic);
    end component;
begin
    U: string_recognizer
        port map (CLK, RST, INPUT, OUTPUT);

    postponed process
        variable i: integer;
    begin
        for i in reference'Range loop
            assert OUTPUT = reference(i)
                report "expected " & std_logic'Image(reference(i)) &
                       " got "     & std_logic'Image(OUTPUT);
            wait until rising_edge(CLK);
        end loop;
    end process;

    process
        variable i: integer;
    begin
        RST <= '1';

        CLK <= '1', '0' after clk_period/2;
        wait for clk_period;

        RST <= '0';

        for i in test_stream'Range loop
            INPUT <= test_stream(i);

            CLK <= '1', '0' after clk_period/2;
            wait for clk_period;
        end loop;
        wait;
    end process;
end test;
