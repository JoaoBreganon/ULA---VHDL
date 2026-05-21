library ieee;
use ieee.std_logic_1164.all;

entity multiplicador is 
    -- m = multiplicando, q = multiplicador, p = produto (resultado final)
    port ( a : in  std_logic_vector (1 downto 0);
           b : in  std_logic_vector (1 downto 0);
           p : out std_logic_vector (3 downto 0));
end multiplicador;

architecture behavioral of multiplicador is 
    
    -- sinais utilizados para o armazenamento do produto parcial da linha x
    signal prod_0, prod_1, prod_2, prod_3 : std_logic;
    
    -- sinal utilizado para o carry
    signal c_1 : std_logic;

begin
    
    --geração dos produtos parciais 0 e 1
    prod_0 <= a(0) and b(0); 
    prod_1 <= a(1) and b(0);
    
    --geração do produto parcial 2 e 3 
    prod_2 <= a(0) and b(1);
    prod_3 <= a(1) and b(1); 

    -- soma dos produtos parciais e geração da saída
    
   -- p(0) é gerado a partir do primeiro produto parcial 
    p(0) <= prod_0;
    
    
    -- a porta xor realiza a soma dos bits
    p(1) <= prod_1 xor prod_2;
    
    -- calculo do carry out intermediário 
    c_1 <= prod_1 and prod_2;
    
    
    -- a porta xor soma o último produto parcial com o carry que veio da coluna anterior
    p(2) <= c_1 xor prod_3;
    
    -- calculo do carry out final
    p(3) <= c_1 and prod_3;

end behavioral;