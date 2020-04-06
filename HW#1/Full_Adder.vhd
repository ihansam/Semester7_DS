library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- std_logic type ����� ���� ���̺귯��

entity Full_Adder is
    port(x, y, cin: in std_logic;       -- Full Adder�� input �� output port�� ���� ����
            sum: out std_logic;         -- (x, y, cin�� ���� ����� carry out�� result�� 
            cout: out std_logic);       -- cout�� sum���� ���)
end Full_Adder;

architecture Behavioral of Full_Adder is    
begin
    sum <= cin xor (x xor y);                               -- sum�� ���� equation
    cout <= (x and y) or (x and cin) or (y and cin);        -- cout�� ���� equation
end Behavioral;