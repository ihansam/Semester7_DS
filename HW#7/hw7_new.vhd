library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

entity Door_Lock is
    port(CLK: in std_logic;
        RESET: in std_logic;
        SET: in std_logic;
        PASSWORD: in integer range 1 to 9;
        LED: out std_logic_vector(4 downto 0)
        );
end Door_Lock;

architecture Behavioral of Door_Lock is
    type num4 is array (1 to 4) of integer range 0 to 9;
    type STATES is (S_setup, S_1st, S_2nd, S_3rd, S_success, S_fail);
    signal state: STATES := S_setup;
    signal nstate: STATES := S_setup;

begin
    state_transition: process(RESET, CLK)
    begin
        if(RESET = '0') then
            state <= S_setup;
        elsif(CLK = '1' and CLK'event) then
            state <= nstate;
        end if;
    end process;
    
    fsm: process(RESET, CLK)
        variable cnt: integer range 0 to 4 := 0;
        variable PWMem: num4 := (0,0,0,0);
        variable tryPW: num4 := (0,0,0,0);
    begin
        if(RESET = '0') then
            nstate <= S_setup;
            cnt := 0;
            PWMem := (0,0,0,0);
            tryPW := (0,0,0,0);
        elsif(CLK = '1' and CLK'event) then
            case state is
                when S_setup =>
                    if (set = '1' and cnt < 4 and PWMem(4)=0) then
                        cnt := 0;
                        PWMem := (0,0,0,0);
                    elsif (PWMem(4)=0) then
                        cnt := cnt + 1;
                        PWMem(cnt):= PASSWORD;
                        if(cnt = 4 and set = '0') then
                            cnt := 0;
                            nstate <= S_1st;
                           end if;
                    end if;
                when S_1st =>
                    if (cnt = 0 and set = '0') then
                        cnt:= 1;
                        tryPW(1) := PASSWORD;
                    elsif (cnt = 1) then
                        cnt := 2;
                        tryPW(2) := PASSWORD;
                    elsif (cnt = 2) then
                        cnt := 3;
                        tryPW(3) := PASSWORD;
                    elsif (cnt = 3) then
                        cnt := 1;
                        tryPW(4) := PASSWORD;
                        if(tryPW = PWMem) then
                            nstate <= S_success;
                        else
                            nstate <= S_2nd;
                        end if;
                    end if;
                when S_2nd =>
                    if (cnt = 4) then
                        tryPW(4) := PASSWORD;
                        cnt := 1;
                        if(tryPW = PWMem) then
                            nstate <= S_success;
                        else
                            nstate <= S_3rd;
                        end if;
                    else
                        tryPW(cnt) := PASSWORD;
                        cnt := cnt + 1;
                    end if;
                when S_3rd =>
                    if (cnt = 4) then
                        tryPW(4) := PASSWORD;
                        cnt := 1;
                        if(tryPW = PWMem) then
                            nstate <= S_success;
                        else
                            nstate <= S_fail;
                        end if;
                    else
                        tryPW(cnt) := PASSWORD;
                        cnt := cnt + 1;
                    end if;
                when others => NULL;
            end case;
        end if;
    end process;

    ledout: process(state)
    begin
        case state is
            when S_setup =>
                LED <= "00000";
            when S_1st =>
                LED <= "01000";
            when S_2nd =>
                LED <= "01001";
            when S_3rd =>
                LED <= "01011";
            when S_success =>
                LED <= "01111";
            when S_fail =>
                LED <= "11000";
            when others => NULL;
        end case;
    end process;

end Behavioral;
