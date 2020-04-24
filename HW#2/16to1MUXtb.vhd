library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity MUX16_TB is
end MUX16_TB;

architecture Behavioral of MUX16_TB is
	component HW2_struct port(                       
        DATA_IN: in std_logic_vector(15 downto 0); 
        S: in std_logic_vector(3 downto 0);
        DATA_OUT: out std_logic);
	end component;                                  
    signal DATA_IN: std_logic_vector(15 downto 0) := "0101101101101001";
    signal S: std_logic_vector(3 downto 0);             
    signal DATA_OUT: std_logic;
begin
	uut : HW2_struct port map (                    
        DATA_IN => DATA_IN,                        
        S => S,                                    
        DATA_OUT => DATA_OUT);

	stim_proc: process
	begin
        for i in 0 to 15 loop                          
            S <= std_logic_vector(to_unsigned(i,4));   
            wait for 10 ns;                            
        end loop;
        wait;
    end process;
end Behavioral;
