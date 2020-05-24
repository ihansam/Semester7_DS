library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BG_Counter is
    port(
    CLK: in std_logic;
    RESET: in std_logic;
    MODE: in std_logic;
    DIR: in std_logic;
    LED: out std_logic_vector(2 downto 0)
    );
end BG_Counter;

architecture Behavioral of BG_Counter is
    type STATES is (s0,s1,s2,s3,s4,s5,s6,s7);
    signal state, next_state: STATES;
begin
    state_transition: process(CLK, RESET)
    begin
        if(RESET = '0') then
            state <= s0;
        elsif(CLK = '1' and CLK'event) then
            state <= next_state;
        end if;
    end process;

    led_out: process(state)
    begin
        if(state = s0) then
            LED <= "000";
        elsif(state = s1) then
            LED <= "001";
        elsif(state = s2) then
            LED <= "010";
        elsif(state = s3) then
            LED <= "011";
        elsif(state = s4) then
            LED <= "100";
        elsif(state = s5) then
            LED <= "101";
        elsif(state = s6) then
            LED <= "110";
        else -- state = s7
            LED <= "111";
        end if;
    end process;

    NEXTstate: process(RESET, MODE, DIR, state)
    begin
		if (state = s0) then
			if (RESET = '0') then
				next_state <= s0;   -- reset
            elsif (MODE = '1' and DIR = '1') then
                next_state <= s1;   -- up binary
            elsif (MODE = '1' and DIR = '0') then
                next_state <= s7;   -- down binary
            elsif (MODE = '0' and DIR = '1') then
                next_state <= s1;   -- up gray
            else -- MODE = '0' and DIR = '0'
                next_state <= s4;   -- down gray
            end if;
        elsif (state = s1) then
			if (RESET = '0') then
				next_state <= s0;
            elsif (MODE = '1' and DIR = '1') then
                next_state <= s2;
            elsif (MODE = '1' and DIR = '0') then
                next_state <= s0;
            elsif (MODE = '0' and DIR = '1') then
                next_state <= s3;
            else -- MODE = '0' and DIR = '0'
                next_state <= s0;
            end if;
        elsif (state = s2) then
			if (RESET = '0') then
				next_state <= s0;
            elsif (MODE = '1' and DIR = '1') then
                next_state <= s3;
            elsif (MODE = '1' and DIR = '0') then
                next_state <= s1;
            elsif (MODE = '0' and DIR = '1') then
                next_state <= s6;
            else -- MODE = '0' and DIR = '0'
                next_state <= s3;
            end if;
        elsif (state = s3) then
			if (RESET = '0') then
				next_state <= s0;
			elsif (MODE = '1' and DIR = '1') then
				next_state <= s4;
			elsif (MODE = '1' and DIR = '0') then
				next_state <= s2;
			elsif (MODE = '0' and DIR = '1') then
				next_state <= s2;
			else -- MODE = '0' and DIR = '0'
				next_state <= s1;
			end if;    
        elsif (state = s4) then
			if (RESET = '0') then
				next_state <= s0;
            elsif (MODE = '1' and DIR = '1') then
                next_state <= s5;
            elsif (MODE = '1' and DIR = '0') then
                next_state <= s3;
            elsif (MODE = '0' and DIR = '1') then
                next_state <= s0;
            else -- MODE = '0' and DIR = '0'
                next_state <= s5;
            end if;
        elsif (state = s5) then
			if (RESET = '0') then
				next_state <= s0;
            elsif (MODE = '1' and DIR = '1') then
                next_state <= s6;
            elsif (MODE = '1' and DIR = '0') then
                next_state <= s4;
            elsif (MODE = '0' and DIR = '1') then
                next_state <= s4;
            else -- MODE = '0' and DIR = '0'
                next_state <= s7;
            end if;
        elsif (state = s6) then
			if (RESET = '0') then
				next_state <= s0;
            elsif (MODE = '1' and DIR = '1') then
                next_state <= s7;
            elsif (MODE = '1' and DIR = '0') then
                next_state <= s5;
            elsif (MODE = '0' and DIR = '1') then
                next_state <= s7;
            else -- MODE = '0' and DIR = '0'
                next_state <= s2;
            end if;
        else    -- state = s7
			if (RESET = '0') then
				next_state <= s0;
            elsif (MODE = '1' and DIR = '1') then
                next_state <= s0;
            elsif (MODE = '1' and DIR = '0') then
                next_state <= s6;
            elsif (MODE = '0' and DIR = '1') then
                next_state <= s5;
            else -- MODE = '0' and DIR = '0'
                next_state <= s6;
            end if;
        end if;
    end process;
end Behavioral;
