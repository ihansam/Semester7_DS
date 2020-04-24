library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4 is             
    port(DATA_IN: in std_logic_vector(3 downto 0);
        S: in std_logic_vector(1 downto 0);
        DATA_OUT: out std_logic);
end MUX4;

architecture Behavior of MUX4 is
begin
    DATA_OUT <= (DATA_IN(0) and not S(1) and not S(0)) 
            or (DATA_IN(1) and not S(1) and S(0)) 
            or (DATA_IN(2) and S(1) and not S(0))
            or (DATA_IN(3) and S(1) and S(0));
end Behavior;
-------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HW2_struct is
    port(DATA_IN: in std_logic_vector(15 downto 0);
        S: in std_logic_vector(3 downto 0);
        DATA_OUT: out std_logic);
end HW2_struct;

architecture Behavioral of HW2_struct is
    component MUX4 port(
        DATA_IN: in std_logic_vector(3 downto 0);
        S: in std_logic_vector(1 downto 0);
        DATA_OUT: out std_logic);
    end component;
    signal FirstSelected: std_logic_vector(3 downto 0);    
begin
    MUX4_0: MUX4 port map(DATA_IN(3 downto 0), S(1 downto 0), FirstSelected(0)); 
    MUX4_1: MUX4 port map(DATA_IN(7 downto 4), S(1 downto 0), FirstSelected(1)); 
    MUX4_2: MUX4 port map(DATA_IN(11 downto 8), S(1 downto 0), FirstSelected(2)); 
    MUX4_3: MUX4 port map(DATA_IN(15 downto 12), S(1 downto 0), FirstSelected(3)); 
    MUX4_4: MUX4 port map(FirstSelected, S(3 downto 2), DATA_OUT); 
end Behavioral;
