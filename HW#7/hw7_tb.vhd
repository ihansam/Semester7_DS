library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Door_Lock_TB is
end Door_Lock_TB;

architecture Behavioral of Door_Lock_TB is
    component Door_Lock is
        port(CLK: in std_logic;
            RESET: in std_logic;
            SET: in std_logic;
            PASSWORD: in integer range 1 to 9;
            LED: out std_logic_vector(4 downto 0)
        );        
    end component;                                  

    signal CLK: std_logic;
    signal RESET: std_logic;
    signal SET: std_logic;
    signal PASSWORD: integer range 1 to 9;
    signal LED: std_logic_vector(4 downto 0);
begin
    DL: Door_Lock port map (CLK => CLK, RESET => RESET,
        SET => SET, PASSWORD => PASSWORD, LED => LED);

    rst_t: process
    begin
        RESET <= '0';
        wait for 25 ns;
        RESET <= '1';
        wait for 190 ns;
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

    DL_t: process
    begin
        PASSWORD <= 3; wait for 25 ns;
        PASSWORD <= 4; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        SET <= '1'; wait for 10 ns;
        PASSWORD <= 5; SET <= '0'; wait for 10 ns;
        PASSWORD <= 6; wait for 10 ns;
        PASSWORD <= 7; wait for 10 ns;
        PASSWORD <= 8; wait for 10 ns;
        SET <= '1'; wait for 10 ns;
        PASSWORD <= 5; SET <= '0'; wait for 10 ns;
        PASSWORD <= 6; wait for 10 ns;
        PASSWORD <= 7; wait for 10 ns;
        PASSWORD <= 9; wait for 10 ns;
        PASSWORD <= 5; wait for 10 ns;
        PASSWORD <= 6; wait for 10 ns;
        PASSWORD <= 7; wait for 10 ns;
        PASSWORD <= 8; wait for 10 ns;
        
        PASSWORD <= 9; wait for 10 ns;
        PASSWORD <= 1; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        PASSWORD <= 4; wait for 10 ns;
        SET <= '1'; wait for 10 ns;
        PASSWORD <= 5; SET <= '0'; wait for 10 ns;
        PASSWORD <= 6; wait for 10 ns;
        PASSWORD <= 7; wait for 10 ns;
        PASSWORD <= 9; wait for 10 ns;
        SET <= '1'; wait for 10 ns;
        PASSWORD <= 1; SET <= '0'; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        PASSWORD <= 8; wait for 10 ns;
        PASSWORD <= 9; wait for 10 ns;
        PASSWORD <= 1; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        PASSWORD <= 7; wait for 10 ns;
        PASSWORD <= 1; wait for 10 ns;
        PASSWORD <= 2; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        PASSWORD <= 6; wait;

    end process;

end Behavioral;
