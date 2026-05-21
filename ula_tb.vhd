library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ula_tb is 
end entity ula_tb;

architecture sim of ula_tb is 
    -- sinais de entrada
    signal a_in       : std_logic_vector(3 downto 0);
    signal b_in       : std_logic_vector(3 downto 0);
    signal opcode_in  : std_logic_vector(2 downto 0);
    
    -- sinais de saída
    signal result_out : std_logic_vector(3 downto 0);
    signal zero_out   : std_logic;
    signal over_out   : std_logic;
    signal cout_out   : std_logic;
    signal equ_out    : std_logic;
    signal grt_out    : std_logic;
    signal lst_out    : std_logic;

begin 
    --instânciamento da ula 
    uut: entity work.ula port map (
        a        => a_in,
        b        => b_in,
        opcode   => opcode_in,
        result   => result_out,
        zero     => zero_out,
        overflow => over_out,
        cout     => cout_out,
        equ      => equ_out,
        grt      => grt_out,
        lst      => lst_out
    );

    -- processo de teste para todos os valores possíveis de B e A, testando todas as combinações com as operações possíveis
    process_estimulos: process 
    begin 
        -- loop mais externo do opcode, de 000 (0) até 111 (7), para seleção da operação
        for k in 0 to 7 loop
            opcode_in <= std_logic_vector(to_unsigned(k, 3));
            
            -- loop do meio de A, de 0000 (0) até 1111 (15)
            for i in 0 to 15 loop
                
                -- loop de B de 0000 (0) até 1111 (15)
                for j in 0 to 15 loop
                    
                    
                    a_in <= std_logic_vector(to_unsigned(i, 4));
                    b_in <= std_logic_vector(to_unsigned(j, 4));
                    
                    
                    wait for 50 ps; 

                end loop;
                -- final do loop de b
                
            end loop;
            -- final do loop de a
            
        end loop;
        -- final do loop do opcode

        wait;
    end process; 

end architecture sim;