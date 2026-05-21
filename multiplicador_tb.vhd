library ieee;
use ieee.std_logic_1164.all;

entity multiplicador_tb is 
end entity multiplicador_tb;

architecture tb of multiplicador_tb is 
    -- sinais de entrada para o multiplicador
    signal m_in  : std_logic_vector(1 downto 0);
    signal q_in  : std_logic_vector(1 downto 0);
    
    -- sinal de saída
    signal p_out : std_logic_vector(3 downto 0);
begin 
    -- instanciação atualizada para mapear as portas 'm' e 'q' da entidade
    uut: entity work.multiplicador port map( 
        a => m_in,
        b => q_in,
        p => p_out
    );

    process 
    begin 
        -- teste m = 00
        m_in <= "00"; q_in <= "00"; wait for 50 ps;
        m_in <= "00"; q_in <= "01"; wait for 50 ps;
        m_in <= "00"; q_in <= "10"; wait for 50 ps;
        m_in <= "00"; q_in <= "11"; wait for 50 ps;

        -- teste m = 01
        m_in <= "01"; q_in <= "00"; wait for 50 ps;
        m_in <= "01"; q_in <= "01"; wait for 50 ps;
        m_in <= "01"; q_in <= "10"; wait for 50 ps;
        m_in <= "01"; q_in <= "11"; wait for 50 ps;

        -- teste m = 10
        m_in <= "10"; q_in <= "00"; wait for 50 ps;
        m_in <= "10"; q_in <= "01"; wait for 50 ps;
        m_in <= "10"; q_in <= "10"; wait for 50 ps;
        m_in <= "10"; q_in <= "11"; wait for 50 ps;

        -- teste m = 11
        m_in <= "11"; q_in <= "00"; wait for 50 ps;
        m_in <= "11"; q_in <= "01"; wait for 50 ps;
        m_in <= "11"; q_in <= "10"; wait for 50 ps;
        m_in <= "11"; q_in <= "11"; wait for 50 ps;
        
        wait; 
    end process;
end architecture tb;