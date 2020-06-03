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
        o_cnt: out integer range 0 to 4;
        o_pw1: out integer;
        o_pw2: out integer;
        o_pw3: out integer;
        o_pw4: out integer;
        o_t1: out integer;
        o_t2: out integer;
        o_t3: out integer;
        o_t4: out integer
        );
end Door_Lock;

architecture Behavioral of Door_Lock is
    type num4 is array (1 to 4) of integer range 0 to 9;
    signal state: integer range 1 to 6 :=1;
    signal nstate: integer range 1 to 6;

begin
    o_state <= state;

    state_trans: process(RESET, CLK)
    begin
        if(RESET = '0') then
            state <= 1;
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
            cnt := 0;
            PWMem := (0,0,0,0);
            tryPW := (0,0,0,0);
        elsif(CLK = '1' and CLK'event) then
            case state is
                when 1 =>
                    if (set = '1' and cnt < 4 and PWMem(4)=0) then
                        cnt := 0;
                        PWMem := (0,0,0,0);
                    elsif (PWMem(4)=0) then
                        cnt := cnt + 1;
                        PWMem(cnt):= PASSWORD;
                        if(cnt = 4 and set = '0') then
                            cnt := 0;
                            nstate <= 2;
                           end if;
                    end if;
                when 2 =>
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
                            nstate <= 5;
                        else
                            nstate <= 3;
                        end if;
                    end if;
                when 3 =>
                    if (cnt = 4) then
                        tryPW(4) := PASSWORD;
                        cnt := 1;
                        if(tryPW = PWMem) then
                            nstate <= 5;
                        else
                            nstate <= 4;
                        end if;
                    else
                        tryPW(cnt) := PASSWORD;
                        cnt := cnt + 1;
                    end if;
                when 4 =>
                    if (cnt = 4) then
                        tryPW(4) := PASSWORD;
                        cnt := 1;
                        if(tryPW = PWMem) then
                            nstate <= 5;
                        else
                            nstate <= 6;
                        end if;
                    else
                        tryPW(cnt) := PASSWORD;
                        cnt := cnt + 1;
                    end if;
                when others => NULL;
            end case;
        end if;
        o_cnt <= cnt;
        o_pw1 <= pwMem(1);
        o_pw2 <= pwMem(2);
        o_pw3 <= pwMem(3);
        o_pw4 <= pwMem(4);  
        o_t1 <= tryPW(1);
        o_t2 <= tryPW(2);
        o_t3 <= tryPW(3);
        o_t4 <= tryPW(4);        
    end process;

    ledout: process(state)
    begin
        case state is
            when 1 =>
                LED <= "00000";
            when 2 =>
                LED <= "01000";
            when 3 =>
                LED <= "01001";
            when 4 =>
                LED <= "01011";
            when 5 =>
                LED <= "01111";
            when 6 =>
                LED <= "11000";
            when others => NULL;
        end case;
    end process;

    
end Behavioral;