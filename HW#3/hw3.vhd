library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ASSIGNMENT is
    port(
    A: in std_logic_vector(3 downto 0);
    B: in std_logic_vector(3 downto 0);
    OP: in std_logic_vector(2 downto 0);
    C: out std_logic_vector(3 downto 0)
    );
end ASSIGNMENT;

architecture Behavioral of ASSIGNMENT is
    function OP_PLUS(
        A: std_logic_vector(3 downto 0);
        B: std_logic_vector(3 downto 0)
        )
        return std_logic_vector is        
        variable C: std_logic_vector(3 downto 0);    
    begin
        C := A+B;
        return C;
    end;

    function OP_MINUS(
        A: std_logic_vector(3 downto 0);
        B: std_logic_vector(3 downto 0)
        )
        return std_logic_vector is
        
        variable C: std_logic_vector(3 downto 0);
    
    begin
        C := A-B;
        return C;
    end;

begin
    process(A, B, OP)
    begin
        if (OP = "000") then
            C <= OP_PLUS(A, B);
        elsif (OP = "001") then
            C <= OP_MINUS(A, B);
        elsif (OP = "010") then
            C <= OP_PLUS(A, "0001");
        elsif (OP = "011") then
            C <= OP_MINUS(A, "0001");
        elsif (OP = "100") then
            C <= A(1 downto 0) & "00";
        elsif (OP = "101") then
            C <= "00" & B(3 downto 2);
        elsif (OP = "110") then
            C <= A(1 downto 0) & (1 downto 0 => A(0));
        else
            C <= (3 downto 2 => B(3)) & B(3 downto 2);
        end if;
    end process;
end Behavioral;
