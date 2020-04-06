library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- std_logic type 사용을 위한 라이브러리

entity Full_Adder is
    port(x, y, cin: in std_logic;       -- Full Adder의 input 및 output port에 대한 정의
            sum: out std_logic;         -- (x, y, cin을 더한 결과의 carry out과 result를 
            cout: out std_logic);       -- cout과 sum으로 출력)
end Full_Adder;

architecture Behavioral of Full_Adder is    
begin
    sum <= cin xor (x xor y);                               -- sum에 대한 equation
    cout <= (x and y) or (x and cin) or (y and cin);        -- cout에 대한 equation
end Behavioral;