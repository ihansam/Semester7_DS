library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HW2_behav is     
    port(DATA_IN: in std_logic_vector(15 downto 0);
        S: in std_logic_vector(3 downto 0);
        DATA_OUT: out std_logic);
end HW2_behav;         

architecture Behavioral of HW2_behav is
begin
    with S select                           
        DATA_OUT <= DATA_IN(0) when "0000", 
                    DATA_IN(1) when "0001", 
                    DATA_IN(2) when "0010", 
                    DATA_IN(3) when "0011",
                    DATA_IN(4) when "0100",
                    DATA_IN(5) when "0101",
                    DATA_IN(6) when "0110",
                    DATA_IN(7) when "0111",
                    DATA_IN(8) when "1000",
                    DATA_IN(9) when "1001",
                    DATA_IN(10) when "1010",
                    DATA_IN(11) when "1011",
                    DATA_IN(12) when "1100",
                    DATA_IN(13) when "1101",
                    DATA_IN(14) when "1110",
                    DATA_IN(15) when others;        
end Behavioral;
-----------------------------------------------------------
library IEEE;	
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_std.ALL;

entity HW2_behav_2 is
    port(DATA_IN: in std_logic_vector(15 downto 0);
        S: in std_logic_vector(3 downto 0);
        DATA_OUT: out std_logic);
end HW2_behav_2;

architecture Behaviorall of HW2_behav_2 is
begin    
    DATA_OUT <= DATA_IN(to_integer(unsigned(S)));
end Behaviorall;
-----------------------------------------------------------