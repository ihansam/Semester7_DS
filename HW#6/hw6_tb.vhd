library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BM_TB is
end BM_TB;

architecture Behavioral of BM_TB is
    component BM port(
        CLK: in std_logic;
        RESET: in std_logic;
        C100: in std_logic;
        C500: in std_logic;
        B1000: in std_logic;
        BUY: in std_logic;
        LEVER: in std_logic;
        BALANCE: out std_logic_vector(5 downto 0);
        DRINK: out std_logic_vector(2 downto 0);
        CHANGE: out std_logic_vector(5 downto 0)    
      );
    end component;                                  

    signal CLK, RESET, C100, C500, B1000, BUY, LEVER: std_logic;
    signal BALANCE, CHANGE: std_logic_vector(5 downto 0);
    signal DRINK: std_logic_vector(2 downto 0);

begin
    machine: BM port map(CLK => CLK, RESET => RESET, C100 => C100,
        C500 => C500, B1000 => B1000, BUY => BUY, LEVER => LEVER,
        BALANCE => BALANCE, DRINK => DRINK, CHANGE => CHANGE);


    ck: process
    begin
        wait for 10 ns;
        CLK <= '1';
        wait for 10 ns;
        CLK <= '0'; 
    end process;

    rst: process
    begin
        RESET <= '0';
        wait for 20 ns;
        RESET <= '1';
        wait;
    end process;

    money: process
    begin
        C100 <= '0'; C500 <= '0'; B1000 <= '0';
        wait for 40 ns; C100 <= '1'; wait for 20 ns; C100 <= '1';
        wait for 20 ns; C100 <= '1'; wait for 20 ns; C100 <= '0';
        wait for 60 ns; C500 <= '1'; wait for 20 ns; C500 <= '1';
        wait for 20 ns; C500 <= '0'; B1000 <= '1';
        wait for 20 ns; B1000 <= '1'; wait for 20 ns; B1000 <= '0';
        wait for 40 ns; B1000 <= '1'; wait for 20 ns; B1000 <= '0';
        wait;
    end process;

    buy_drink : process
    begin
        BUY <= '0'; wait for 100 ns; BUY <= '1'; wait for 20 ns;
        BUY <= '0'; wait for 120 ns; BUY <= '1'; wait for 40 ns;
        BUY <= '0'; wait;
    end process;
        
    lever_i : process
    begin
        LEVER <= '0'; wait for 120 ns; LEVER <= '1'; wait for 20 ns;
        LEVER <= '0'; wait for 160 ns; LEVER <= '1'; wait for 20 ns;
        LEVER <= '0'; wait;
    end process;

end Behavioral;
