library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TL_tb is
end TL_tb;

architecture Behavioral of TL_tb is
    component TAIL_LIGHT is
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        BREAK: in std_logic;
        LEFT: in std_logic;
        RIGHT: in std_logic;
        LED: out std_logic_vector(7 downto 0)
    );
    end component;                                  

    signal CLK: std_logic;
    signal RESET: std_logic;
    signal BREAK: std_logic;
    signal LEFT: std_logic;
    signal RIGHT: std_logic;
    signal LED: std_logic_vector(7 downto 0);

begin
    t_l: TAIL_LIGHT port map(CLK => CLK, RESET => RESET, BREAK => BREAK, LEFT => LEFT, RIGHT => RIGHT, LED => LED);

    rst_t: process
    begin
        wait for 10 ns;
        RESET <= '0';
        wait for 20 ns;
        RESET <= '1';
        wait for 50 ns;
        RESET <= '0';
        wait for 10 ns;
        RESET <= '1';
        wait;
    end process;

    clk_t: process
    begin
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
        CLK <= '0';
    end process;

    tl_t: process
    begin
        wait for 10 ns;
        BREAK <= '0';
        LEFT <= '0';
        RIGHT <= '0';
        wait for 60 ns;
        BREAK <= '1';
        wait for 20 ns;
        BREAK <= '0';
        LEFT <= '1';
        wait for 20 ns;
        BREAK <= '1';
        LEFT <= '0';
        wait for 60 ns;
        BREAK <= '0';
        RIGHT <= '1';
        wait for 20 ns;
        RIGHT <= '0';
        wait for 20 ns;
        LEFT <= '1';
        RIGHT <= '1';
        wait for 20 ns;
        RIGHT <= '0';
        wait for 20 ns;
        BREAK <= '1';
        LEFT <= '1';
        wait;
    end process;
end Behavioral;
