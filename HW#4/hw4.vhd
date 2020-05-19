library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TAIL_LIGHT is
    port(
    CLK: in std_logic;
    RESET: in std_logic;
    BREAK: in std_logic;
    LEFT: in std_logic;
    RIGHT: in std_logic;
    LED: out std_logic_vector(7 downto 0)
    );
end TAIL_LIGHT;

architecture Behavioral of TAIL_LIGHT is
    type STATES is (S_reset, S_ready, S_break, S_left, S_right);
    signal state: STATES := S_reset;
    signal next_state: STATES;
begin
    state_transition: process(CLK, RESET)
    begin
        if(RESET = '0') then
            state <= S_reset;
        elsif(CLK = '1' and CLK'event) then
            state <= next_state;
        end if;
    end process;

    led_out: process(state)
    begin
        if(state = S_reset) then
            LED <= "00000000";
        elsif(state = S_ready) then
            LED <= "10000001";
        elsif(state = S_break) then
            LED <= "11111111";
        elsif(state = S_left) then
            LED <= "11110000";
        else -- state = S_right
            LED <= "00001111";
        end if;
    end process;

    NEXTstate: process(RESET, BREAK, LEFT, RIGHT, state)
    begin
        case state is
            when S_reset =>
                if RESET = '1' then next_state <= S_ready; end if;
            when S_ready =>
                if BREAK = '1' then next_state <= S_break;
                elsif LEFT='1' and RIGHT = '0' then next_state <= S_left;
                elsif LEFT ='0' and RIGHT = '1' then next_state <= S_right;
                else next_state <= S_ready; end if;
            when S_break =>
                if BREAK = '0' then next_state <= S_ready;
                else next_state <= S_break; end if;
            when S_left =>
                if BREAK = '1' then next_state <= S_break;
                elsif LEFT = '1' then next_state <= S_left;
                else next_state <= S_ready; end if;
            when S_right =>
                if BREAK = '1' then next_state <= S_break;
                elsif RIGHT = '1' then next_state <= S_right;
                else next_state <= S_ready; end if;
        when others => null;
        end case;
    end process;
end Behavioral;
