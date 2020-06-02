library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

entity BM is
    port(
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
end BM;

architecture Behavioral of BM is
    type STATES is (S_ready, S_cngrst);
    signal state: STATES;
    signal in_bal: integer range 0 to 40 := 0;
    signal in_drk: integer range 0 to 7 := 0;
    signal in_cng: integer range 0 to 40 := 0;

begin
    BALANCE <= conv_std_logic_vector(in_bal, 6);
    DRINK <= conv_std_logic_vector(in_drk, 3);
    CHANGE <= conv_std_logic_vector(in_cng, 6);

    process(CLK, RESET)
    begin
        if(RESET = '0') then
            state <= S_ready;
            in_bal <= 0;
            in_drk <= 0;
            in_cng <= 0;
        elsif(CLK = '1' and CLK'event) then
            case state is
                when S_ready =>
                    if (LEVER = '1') then
                        state <= S_cngrst;
                        in_cng <= in_bal;
                        in_bal <= 0;
                        in_drk <= 0;
                    elsif (BUY = '1' and in_bal >= 7) then
                        in_drk <= in_drk + 1;
                        in_bal <= in_bal - 7;
                    elsif (B1000 = '1') then
                        in_bal <= in_bal + 10;
                    elsif (C500 = '1') then
                        in_bal <= in_bal + 5;
                    elsif (C100 = '1') then
                        in_bal <= in_bal + 1;
                    end if;
                when S_cngrst=>
                    in_cng <= 0;
                    state <= S_ready;
                when others => NULL;
            end case;
        end if;
    end process;

--    NEXTstate: process(state, LEVER)
--    begin
--        case state is
--        when S_ready =>
--            if (LEVER = '1') then next_state <= S_cngrst;
--            else next_state <= S_ready; end if;
--        when S_cngrst =>
--            next_state <= S_ready;
--        when others => NULL; 
--        end case;
--    end process;

    
end Behavioral;
