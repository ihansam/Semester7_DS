library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_4bit is
    port (x, y : in std_logic_vector (3 downto 0);
            cin: in std_logic ;
            sum : out std_logic_vector (3 downto 0);
            cout : out std_logic);
end Adder_4bit;

architecture Behavioral of   Adder_4bit is
    component Full_Adder port(
        x, y, cin : in std_logic;
            sum : out std_logic;
            cout: out std_logic);
    end component;
    signal c: std_logic_vector (3 downto 1);
begin
    FA0: Full_Adder port map (x(0), y(0), cin, sum(0), c(1));
    FA1: Full_Adder port map (x(1), y(1), c(1), sum(1), c(2));
    FA2: Full_Adder port map (x(2), y(2), c(2), sum(2), c(3));
    FA3: Full_Adder port map (x(3), y(3), c(3), sum(3), cout);
end Behavioral;