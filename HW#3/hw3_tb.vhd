library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ASSIGN3_TB is
end ASSIGN3_TB;

architecture Behavioral of ASSIGN3_TB is
    component ASSIGNMENT port(
        A: in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
        OP: in std_logic_vector(2 downto 0);
        C: out std_logic_vector(3 downto 0)
        );
    end component;                                  
    signal A: std_logic_vector(3 downto 0);
    signal B: std_logic_vector(3 downto 0);             
    signal OP: std_logic_vector(2 downto 0);
    signal C: std_logic_vector(3 downto 0);

begin
    ALU: ASSIGNMENT port map(A => A, B => B, OP => OP, C => C);

    AB: process
    begin
        wait for 10 ns;
        A <= "1010";
        B <= "0111";
        wait for 80 ns;
        A <= "0011";
        B <= "0110";
        wait;
    end process;

    opcode: process
    begin
        wait for 10 ns;
        OP <= "000";
        wait for 10 ns;
        OP <= "001";
        wait for 10 ns;
        OP <= "010";
        wait for 10 ns;
        OP <= "011";
        wait for 10 ns;
        OP <= "100";
        wait for 10 ns;
        OP <= "101";
        wait for 10 ns;
        OP <= "110";
        wait for 10 ns;
        OP <= "111";
    end process;
    
end Behavioral;
