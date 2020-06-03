library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

entity Door_Lock is
    port(CLK: in std_logic;
        RESET: in std_logic;
        SET: in std_logic;
        PASSWORD: in integer range 1 to 9;
        LED: out std_logic_vector(4 downto 0));
end Door_Lock;

architecture Behavioral of Door_Lock is
    type num4 is array (1 to 4) of integer range 0 to 9;
    type STATES is (S_setup, S_trial, S_done);
    -- setting password, try unlock, unlock or locked
    signal state: STATES := S_setup;
    signal tryCnt: integer range 0 to 3 := 0;
    signal done: std_logic := 0;

begin
    fsm: process(RESET, CLK)
    begin
        if(RESET = '0') then
            state <= S_setup;
        elsif(CLK = '1' and CLK'event) then
            case state is
                when S_setup =>
                    if (done = '1') then state <= S_trial; end if;
                when S_trial =>
                    if (doen = '1') then state <= S_done; end if;
                when S_done =>
                    state <= S_done;
                when others => NULL;
            end case;
        end if;
    end process;

    led: process(state)
    begin
        case state is
            when S_setup =>
                LED <= "00000";
            when S_trial =>
                if (tryCnt = 0) then
                    LED <= "01000";
                elsif (tryCnt = 1) then
                    LED <= "01001";
                elsif (tryCnt = 2) then
                    LED <= "01011";
                end if;
            when S_done =>
                if (tryCnt <= 2) then
                    LED <= "01111";     -- success to unlock
                else LED <= "11000";    -- unlock forever
                end if;
            when others => NULL;
        end case;
    end process;

    CntDoneLogic: process(RESET, CLK)
        variable cnt: integer range 0 to 4 := 0;
        variable pwMemory: num4 := (0,0,0,0);
    begin
        done <= '0';
        if(RESET = '0') then
            done <= '0';
            tryCnt <= 0;
        elsif(CLK = '1' and CLK'event) then
            case state is
                when S_setup =>
                    if (set = '1' and cnt /= 4) then
                        cnt := 0;
                        pwMemory := (0,0,0,0);
                    elsif (set = '1' and cnt = 4) then
                        cnt := 0;
                        done <= '1';
                    else
                        cnt := cnt + 1;
                        pwMemory(cnt) := PASSWORD;
                    end if;
                when S_trial =>
                    
                when S_done =>

                when others => NULL;
            end case;
        end if;
        
    end process;


    
end Behavioral;
