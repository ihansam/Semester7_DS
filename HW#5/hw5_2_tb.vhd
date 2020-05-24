library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Seq_Dec_TB is
end Seq_Dec_TB;

architecture Behavioral of Seq_Dec_TB is
    component Seq_Detector is
    port(
		CLK: in std_logic;
		RESET: in std_logic;
		X: in std_logic;
		Z: out std_logic
		);
    end component;                                  

    signal CLK: std_logic;
    signal RESET: std_logic;
    signal X, Z: std_logic;

begin
    SD: Seq_Detector port map(CLK => CLK, RESET => RESET, X => X, Z => Z);

    rst_t: process
    begin
        RESET <= '0';
        wait for 20 ns;
        RESET <= '1';
        wait for 100 ns;
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
		X <= '0';
		wait for 25ns;
		X <= '1';
		wait for 20ns;
		X <= '0';
		wait for 10ns;
		X <= '1';
		wait for 20ns;
		X <= '0';
		wait for 10ns;
		X <= '1';
		wait for 10ns;
		X <= '0';
		wait for 10ns;
		X <= '1';
		wait for 10ns;
		X <= '0';
		wait for 10ns;
		X <= '1';
		wait for 10ns;
		X <= '0';
		wait;
    end process;
	
end Behavioral;
