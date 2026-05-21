library ieee;
use ieee.std_logic_1164.all;

entity top_level is 
    port (
        SW   : in  std_logic_vector(10 downto 0); -- Chaves: a(10..7), b(6..3), Opcode(2..0) 
        HEX0 : out std_logic_vector(6 downto 0);  -- Display do Opcode 
        HEX2 : out std_logic_vector(6 downto 0);  -- Display de B 
        HEX4 : out std_logic_vector(6 downto 0);  -- Display de A 
        HEX6 : out std_logic_vector(6 downto 0);  -- Display do Result 
        LEDR : out std_logic_vector(5 downto 0)   -- Flags: Lst, Grt, Equ, overflow, zero, cout 
    );
end entity top_level;

architecture estrutural of top_level is 
    -- Sinal interno para o resultado da ULA
    signal ula_result : std_logic_vector(3 downto 0);

    -- FUNÇÃO DECODIFICADORA
    function conv_7seg(entrada : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable saida : std_logic_vector(6 downto 0);
    begin
        case entrada is
            when "0000" => saida := "1000000"; -- 0
            when "0001" => saida := "1111001"; -- 1
            when "0010" => saida := "0100100"; -- 2
            when "0011" => saida := "0110000"; -- 3
            when "0100" => saida := "0011001"; -- 4
            when "0101" => saida := "0010010"; -- 5
            when "0110" => saida := "0000010"; -- 6
            when "0111" => saida := "1111000"; -- 7
            when "1000" => saida := "0000000"; -- 8
            when "1001" => saida := "0010000"; -- 9
            when "1010" => saida := "0001000"; -- A
            when "1011" => saida := "0000011"; -- b
            when "1100" => saida := "1000110"; -- C
            when "1101" => saida := "0100001"; -- d
            when "1110" => saida := "0000110"; -- E
            when "1111" => saida := "0001110"; -- F
            when others => saida := "1111111"; -- Apagado
        end case;
        return saida;
    end function;

begin
  
    inst_ula: entity work.ula port map (
        a        => SW(10 downto 7), -- Entrada A
        b        => SW(6 downto 3),  -- Entrada B
        opcode   => SW(2 downto 0),  -- Seletor de operação
        result   => ula_result,
        cout     => LEDR(0),         -- LEDR0 
        zero     => LEDR(1),         -- LEDR1 
        overflow => LEDR(2),         -- LEDR2 
        equ      => LEDR(3),         -- LEDR3
        grt      => LEDR(4),         -- LEDR4
        lst      => LEDR(5)          -- LEDR5 
    );

    HEX0 <= conv_7seg('0' & SW(2 downto 0)); -- Mostra o Opcode 
    HEX2 <= conv_7seg(SW(6 downto 3));        -- Mostra o valor de B 
    HEX4 <= conv_7seg(SW(10 downto 7));       -- Mostra o valor de A 
    HEX6 <= conv_7seg(ula_result);            -- Mostra o Resultado final 

end architecture estrutural;