library ieee;
use ieee.std_logic_1164.all;

entity comparador_4bits is 
    port (
        a   : in std_logic_vector(3 downto 0);
        b   : in std_logic_vector(3 downto 0);
        Lst : out std_logic;
        Grt : out std_logic;
        Equ : out std_logic
    );
end entity comparador_4bits;

architecture estrutural of comparador_4bits is 

	signal eq_teste : std_logic_vector(3 downto 0);

	begin 
	--teste da igualdade dos bits de a e b
	eq_teste <= a XNOR b; 
	
	--se todos os bits de a e b forem iguais a saída será 1 e equ será ligado
	Equ <= eq_teste(0) AND eq_teste(1) AND eq_teste(2) AND eq_teste(3);
	
	 -- Maior que (Grt)
    -- A > B, sempre priorizando o MSB até o LSB 
    Grt <= (a(3) AND NOT b(3)) OR
           (eq_teste(3) AND a(2) AND NOT b(2)) OR
           (eq_teste(3) AND eq_teste(2) AND a(1) AND NOT b(1)) OR
           (eq_teste(3) AND eq_teste(2) AND eq_teste(1) AND a(0) AND NOT b(0));

    -- Menor que (Lst)
    -- A < B, sempre priorizando o MSB até o LSB 
    Lst <= (NOT a(3) AND b(3)) OR
           (eq_teste(3) AND NOT a(2) AND b(2)) OR
           (eq_teste(3) AND eq_teste(2) AND NOT a(1) AND b(1)) OR
           (eq_teste(3) AND eq_teste(2) AND eq_teste(1) AND NOT a(0) AND b(0));

end architecture estrutural;