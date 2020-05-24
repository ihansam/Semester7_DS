library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter_tb is
end Counter_tb;

architecture Behavioral of Counter_tb is
    component BG_Counter is
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        MODE: in std_logic;
        DIR: in std_logic;
        LED: out std_logic_vector(2 downto 0)
    );
    end component;                                  

    signal CLK: std_logic;
    signal RESET: std_logic;
    signal MODE: std_logic;
    signal DIR: std_logic;
    signal LED: std_logic_vector(2 downto 0);

begin
    BG: BG_Counter port map(CLK => CLK, RESET => RESET, MODE => MODE, DIR => DIR, LED => LED);

    rst_t: process
    begin
		RESET <= '0';
        wait for 20 ns;
        RESET <= '1';
        wait for 200 ns;
        RESET <= '0';
        wait for 10 ns;
        RESET <= '1';
        wait;
    end process;

    clk_t: process
    begin
        CLK <= '1';
        wait for 5 ns;
        CLK <= '0';
        wait for 5 ns;
    end process;

    tl_t: process
    begin
		MODE <= '1';
		DIR <= '1';
        wait for 55 ns;		-- binary up cnt
		DIR <= '0';
        wait for 40 ns;		-- binary down cnt
		MODE <= '0';
		wait for 50 ns;		-- gray down cnt
		DIR <= '1';
        wait for 100 ns;	-- gray up cnt
		MODE <= '1';
		DIR <= '0';
        wait;				-- binary down cnt
    end process;
end Behavioral;
