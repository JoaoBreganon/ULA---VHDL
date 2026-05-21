library IEEE;
use ieee.std_logic_1164.all;

package adder is 
	component somador_completo is --declaração do somador completo e suas componentes utilizadas
		port (
				a,b, cin: in std_logic;
				sum, cout: out std_logic);
	end component;
	
	component somador_4bits is --declaração do somador de 4 bits com um carry out se necessário
		port (
				a : in std_logic_vector(3 downto 0);
				b : in  std_logic_vector(3 downto 0);
				cin  : in  std_logic;                   
				s    : out std_logic_vector(3 downto 0);
				cout : out std_logic 
			); 
	end component;
	
	component multiplicador_2bits is --declaração do multiplicador de 2 bits com uma saída de 4
		port ( 
				a : in std_logic_vector(1 downto 0);
				b: in std_logic_vector(1 downto 0);
				p: out std_logic_vector(3 downto 0)
				);
	end component;
	
	component comparador_4bits is --declaração de um comparador de 4 bits o qual da o display entre 2 resultados (=,< ou >)
		port (
				a : in std_logic_vector(3 downto 0);
				b: in std_logic_vector(3 downto 0);
				Lst : out std_logic;
				Grt : out std_logic;
				Equ: out std_logic
			);
	end component;

end package adder; 			