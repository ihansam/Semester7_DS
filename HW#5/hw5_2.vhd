library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Seq_Detector is
    port(
    CLK: in std_logic;
    RESET: in std_logic;
    X: in std_logic;
    Z: out std_logic
    );
end Seq_Detector;

architecture Behavioral of Seq_Detector is
    type STATES is (s_init, s_1, s_10, s_101);
    signal state, next_state: STATES;
begin
    state_transition: process(CLK, RESET)
    begin
        if(RESET = '0') then
            state <= s_init;
        elsif(CLK = '1' and CLK'event) then
            state <= next_state;
        end if;
    end process;

    led_out: process(state, X)
    begin
		case state is
			when s_init =>
				Z <= '0';
			when s_1 =>
				Z <= '0';
			when s_10 =>
				Z <= '0';
			when s_101 =>           -- Z = 1 only when
				if (X = '0') then   -- X = 1010 entered
					Z <= '1';
				else
					Z <= '0';
				end if;
			when others => null;
		end case;
    end process;

    NEXTstate: process(state, X)
    begin
        case state is
            when s_init =>
                if (X = '0') then next_state <= s_init;
                else next_state <= s_1; -- when X = '1'
                end if;
            when s_1 =>
                if (X = '0') then next_state <= s_10;
                else next_state <= s_1; -- when X = '1'
                end if;
            when s_10 =>
                if (X = '0') then next_state <= s_init;
                else next_state <= s_101; -- when X = '1'
                end if;
            when s_101 =>
                if (X = '0') then next_state <= s_10;
                else next_state <= s_1; -- when X = '1'
                end if;
            when others => null;
        end case;
    end process;
end Behavioral;
