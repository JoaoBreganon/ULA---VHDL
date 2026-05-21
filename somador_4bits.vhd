library ieee;
use ieee.std_logic_1164.all;
use work.adder.all; -- definição de bibliotecas 

entity somador_4bits is -- definição das portas de entrada e saída
	port( 
		a: in std_logic_vector(3 downto 0);
		b: in std_logic_vector(3 downto 0);
		cin : in std_logic;
		s: out std_logic_vector(3 downto 0);
		cout: out std_logic 
	);
end entity somador_4bits;

architecture estrutural of somador_4bits is 

signal c1,c2,c3: std_logic; -- definição de signals para utilização do cin e cout nas somas

begin 
	stage_0: somador_completo port map ( --estágio inicial do somador utilizando a lógica base do somador completo
        a => a(0), 
        b => b(0), 
        cin => cin,
        sum => s(0), 
        cout => c1
    );
	 
    stage_1: somador_completo port map ( --estágio 1 do somador, utilizando c1 da soma anterior como cin dessa
        a => a(1), 
        b => b(1), 
        cin => c1,
        sum => s(1), 
        cout => c2
    );

 
    stage_2: somador_completo port map ( --estágio 2 do somador, utilizando c2 da soma anterior como cin dessa
        a => a(2), 
        b => b(2), 
        cin => c2,
        sum => s(2), 
        cout => c3
    );


    stage_3: somador_completo port map ( --estágio 3 do somador, utilizando c3 da soma anterior como cin dessa
        a => a(3), 
        b => b(3), 
        cin => c3,
        sum => s(3), 
        cout => cout 
    );

end architecture estrutural;