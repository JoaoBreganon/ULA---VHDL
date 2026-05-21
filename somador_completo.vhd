library ieee;
use ieee.std_logic_1164.all;

entity somador_completo is --declara as portas de entrada e saída utilizadas pelo somador
    port (
        a, b, cin: in std_logic;
        sum, cout: out std_logic
    );
end entity somador_completo;

architecture bhv of somador_completo is --declara o behavior do somador completo
begin
    sum <= a XOR b XOR cin; --calcula a soma das 3 entradas
    cout <= (a AND b) OR (cin AND (a XOR b));--calcula qual será o carry out
end architecture bhv;