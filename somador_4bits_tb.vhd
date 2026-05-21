library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador_4bits_tb is 
end entity somador_4bits_tb;

architecture tb of somador_4bits_tb is --Cria o ambiente de simulação para o teste do somador de 4 bits 
    signal a_in   : std_logic_vector(3 downto 0);-- sinais de entradas do somador de 4 bits 
    signal b_in   : std_logic_vector(3 downto 0);
    signal cin_in : std_logic;
     
    signal s_out    : std_logic_vector(3 downto 0); --sinais de saída do somador de 4 bits
    signal cout_out : std_logic;
begin 
    uut: entity work.somador_4bits port map( --conexão dos sinais do testbench com os pinos
          a    => a_in, 
          b    => b_in, 
          cin  => cin_in,
          s    => s_out, 
          cout => cout_out
    );
 process --Teste de todas as combinações possíveis
    begin 
        -- for inicial para o loop de A para o teste com cin = 0
        for i in 0 to 15 loop
            --for secundário para o loop de B para o teste com cin = 0 
            for j in 0 to 15 loop
                
               --conversão do valor de i e j para um número não sinalizado de 4 bits 
                a_in <= std_logic_vector(to_unsigned(i, 4));
                b_in <= std_logic_vector(to_unsigned(j, 4));
                
                --teste do cin = 0, para todas as somas puras, sem serem afetadas pelo cin
                cin_in <= '0'; 
                wait for 50 ps; 

            end loop;-- final do loop de b
        end loop;--final do loop de a
        
        -- for inicial para o loop de A para o teste com cin = 1
        for i in 0 to 15 loop
            --for secundário para o loop de B para o teste com cin = 1
            for j in 0 to 15 loop
                
                a_in <= std_logic_vector(to_unsigned(i, 4));
                b_in <= std_logic_vector(to_unsigned(j, 4));
                
                --teste do cin = 1, para todas as somas afetadas pelo cin 
                cin_in <= '1'; 
                wait for 50 ps; 

            end loop;
        end loop;

        wait;
    end process;
end architecture tb; 