library ieee;
use ieee.std_logic_1164.all;

entity somador_completo_tb is 
end entity somador_completo_tb;

architecture tb of somador_completo_tb is --Cria o ambiente de simulação para o teste do somador completo
    signal vetor_e: std_logic_vector(2 downto 0);
    signal sum_s, cout_s: std_logic;
begin 
    uut: entity work.somador_completo port map( --conexão dos sinais do testbench com os pinos
        a => vetor_e(0), 
        b => vetor_e(1), 
        cin => vetor_e(2),
        sum => sum_s, 
        cout => cout_s
    );

    process --Teste de todas as 8 combinações possíveis a cada 100ps
    begin 
        vetor_e <= "000"; wait for 100 ps;
        vetor_e <= "001"; wait for 100 ps;
        vetor_e <= "010"; wait for 100 ps;
        vetor_e <= "011"; wait for 100 ps;
        vetor_e <= "100"; wait for 100 ps;
        vetor_e <= "101"; wait for 100 ps;
        vetor_e <= "110"; wait for 100 ps;
        vetor_e <= "111"; wait for 100 ps;
        wait;
    end process;
end architecture tb;