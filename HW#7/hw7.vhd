library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

entity Door_Lock is
    port(CLK: in std_logic;
        RESET: in std_logic;
        SET: in std_logic;
        PASSWORD: in integer range 1 to 9;
        LED: out std_logic_vector(4 downto 0);
        o_state: out integer range 0 to 3;
        o_tryCnt: out integer range 0 to 3;
        o_done: out std_logic;
        o_cnt: out integer range 0 to 4
        );
end Door_Lock;

architecture Behavioral of Door_Lock is
    type num4 is array (1 to 4) of integer range 0 to 9;
    -- type STATES is (S_setup, S_trial, S_done);
    -- setting password, try unlock, unlock or locked
    -- signal state: STATES := S_setup;
    signal state: integer range 0 to 2;
    signal tryCnt: integer range 0 to 3 := 0;
    signal done: std_logic := '0';

begin
    o_state <= state;
    o_tryCnt <= tryCnt;
    o_done <= done;

    fsm: process(RESET, CLK)
    begin
        if(RESET = '0') then
            state <= 0;
        elsif(CLK = '1' and CLK'event) then
            case state is
                when 0 =>
                    if (done = '1') then state <= 1; end if;
                when 1 =>
                    if (done = '1') then state <= 2; end if;
                when 2 =>
                    state <= 2;
                when others => NULL;
            end case;
        end if;
    end process;

    ledout: process(state, tryCnt)
    begin
        case state is
            when 0 =>
                LED <= "00000";
            when 1 =>
                if (tryCnt = 0) then
                    LED <= "01000";
                elsif (tryCnt = 1) then
                    LED <= "01001";
                elsif (tryCnt = 2) then
                    LED <= "01011";
                end if;
            when 2 =>
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
        variable tryPW: num4 := (0,0,0,0);
    begin
        if(RESET = '0') then
            done <= '0';
            tryCnt <= 0;
            cnt := 0;
            pwMemory := (0,0,0,0);
            tryPW := (0,0,0,0);
        elsif(CLK = '1' and CLK'event) then
            done <= '0';
            case state is
                when 0 =>
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
                when 1 =>
                    if (cnt = 3) then
                        if (not(pwMemory(1)=tryPW(1) and pwMemory(2) = tryPW(2)
                        and pwMemory(3)=tryPW(3) and pwMemory(4)=PASSWORD)) then
                            if (tryCnt = 2) then done <= '1'; end if;
                            tryCnt <= tryCnt + 1;
                            cnt := 1;
                            tryPW := (0,0,0,0);
                        else done <= '1';
                        end if;
                    else
                        cnt := cnt+1;
                        tryPW(cnt) := PASSWORD;
                    end if;
                when 2 => NULL;
                when others => NULL;
            end case;
        end if;
    o_cnt <= cnt;        
    end process;
    
end Behavioral;
