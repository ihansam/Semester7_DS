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
            LED: out std_logic_vector(4 downto 0);
            o_state: out integer range 0 to 3;
            o_tryCnt: out integer range 0 to 3;
            o_done: out std_logic;
            o_cnt: out integer range 0 to 4;
            o_pw1: out integer;
            o_pw2: out integer;
            o_pw3: out integer;
            o_pw4: out integer;
        o_t1: out integer;
        o_t2: out integer;
        o_t3: out integer;
        o_t4: out integer            );
            
    end component;                                  

    signal CLK: std_logic;
    signal RESET: std_logic;
    signal SET: std_logic;
    signal PASSWORD: integer range 1 to 9;
    signal LED: std_logic_vector(4 downto 0);
    signal o_state: integer range 0 to 3;
    signal o_tryCnt: integer range 0 to 3;
    signal o_done: std_logic;
    signal o_cnt: integer range 0 to 4;
    signal o_pw1: integer;
    signal o_pw2: integer;
    signal o_pw3: integer;
    signal o_pw4: integer;
    signal o_t1: integer;
       signal o_t2: integer;
       signal o_t3: integer;
       signal o_t4: integer;
begin
    DL: Door_Lock port map (CLK => CLK, RESET => RESET,
        SET => SET, PASSWORD => PASSWORD, LED => LED,
        o_state => o_state, o_tryCnt => o_tryCnt, o_done => o_done, o_cnt => o_cnt,
        o_pw1 => o_pw1, o_pw2 => o_pw2, o_pw3 => o_pw3, o_pw4 => o_pw4,
        o_t1 => o_t1, o_t2 => o_t2, o_t3 => o_t3, o_t4 => o_t4);

    rst_t: process
    begin
        RESET <= '0';
        wait for 25 ns;
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
        SET <= '0';
        PASSWORD <= 3; wait for 25 ns;
        PASSWORD <= 4; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        SET <= '1'; wait for 10 ns;
        SET <= '0'; PASSWORD <= 1; wait for 10 ns;
        PASSWORD <= 2; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        PASSWORD <= 4; wait for 10 ns;
        SET <= '1'; wait for 10 ns;
        SET <= '0'; PASSWORD <= 3; wait for 10 ns;
        PASSWORD <= 4; wait for 10 ns;
        PASSWORD <= 1; wait for 10 ns;
        PASSWORD <= 2; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        PASSWORD <= 4; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        PASSWORD <= 4; wait for 10 ns;
        PASSWORD <= 1; wait for 10 ns;
        PASSWORD <= 2; wait for 10 ns;
        PASSWORD <= 3; wait for 10 ns;
        PASSWORD <= 4; wait;
    end process;

end Behavioral;
