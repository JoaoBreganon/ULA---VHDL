library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparador_4bits_tb is
end entity;

architecture sim of comparador_4bits_tb is
    
 
    component comparador_4bits 
        port (
            a   : in std_logic_vector(3 downto 0);
            b   : in std_logic_vector(3 downto 0);
            Lst : out std_logic;
            Grt : out std_logic;
            Equ : out std_logic
        );
    end component;

    -- Sinais declarados para a conexão com o componente 
    signal a_s, b_s : std_logic_vector(3 downto 0) := "0000";
    signal Lst_s, Grt_s, Equ_s : std_logic;

begin 
    
    -- Instanciação correta batendo com o nome do componente
    uut: comparador_4bits port map( 
        a   => a_s, 
        b   => b_s, 
        Lst => Lst_s,
        Grt => Grt_s,
        Equ => Equ_s
    );

    -- processo de teste entre duas variáveis, testando todas as possibilidades pra A e B 
    process_estimulos: process 
    begin 
        -- loop de fora de A 
        for i in 0 to 15 loop
            
            -- loop de fora de B
            for j in 0 to 15 loop
                
                a_s <= std_logic_vector(to_unsigned(i, 4));
                b_s <= std_logic_vector(to_unsigned(j, 4));
                
                wait for 50 ps; 

            end loop; -- final do loop de b
        end loop; -- final do loop de a

        wait;
    end process; 

end architecture;