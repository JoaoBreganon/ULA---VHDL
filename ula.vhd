library ieee;
use ieee.std_logic_1164.all;
use work.adder.all; -- pega os componentes do projeto

entity ula is 
    port (
        a        : in  std_logic_vector(3 downto 0);
        b        : in  std_logic_vector(3 downto 0);
        opcode   : in  std_logic_vector(2 downto 0);
        result   : out std_logic_vector(3 downto 0);
        zero     : out std_logic;
        overflow : out std_logic;
        cout     : out std_logic;
        equ      : out std_logic;
        grt      : out std_logic;
        lst      : out std_logic
    );
end entity ula;

architecture estrutural of ula is 
    --sinais internos para cada um dos blocos
    signal res_and, res_or, res_not : std_logic_vector(3 downto 0);
    signal res_addsub, res_mul      : std_logic_vector(3 downto 0);
    signal res_int                  : std_logic_vector(3 downto 0);
    
    -- sinais de controle para o somador e subtrator
    signal b_addsub    : std_logic_vector(3 downto 0);
    signal cin_addsub  : std_logic;
    signal cout_addsub : std_logic;
    
    -- sinais para armazenamento dos retornos do comparador
    signal eq_int, grt_int, lst_int : std_logic;

begin 
    
    
    
    -- lógica inicial para o subtrator e somador 
    b_addsub   <= not b when opcode = "101" else b;
    cin_addsub <= '1' when opcode = "101" else '0';
    
    --instanciamento do somador
    inst_somador: somador_4bits port map (
        a    => a, 
        b    => b_addsub, 
        cin  => cin_addsub, 
        s    => res_addsub, 
        cout => cout_addsub
    );

    -- instanciamento do multiplicador
    inst_multiplicador: entity work.multiplicador port map (
        a => a(1 downto 0), 
        b => b(1 downto 0), 
        p => res_mul
    );

    -- instanciação do comparador de 4 bits
    inst_comparador: comparador_4bits port map (
        a   => a, 
        b   => b, 
        Lst => lst_int, 
        Grt => grt_int, 
        Equ => eq_int
    );



    res_and <= a and b;
    res_or  <= a or b;
    res_not <= not b;

    
    -- multiplexador para a seleção de cada um dos sinais
    
    with opcode select res_int <=
        "0000"     when "000", -- NOP
        res_and    when "001", -- AND
        res_or     when "010", -- OR
        res_not    when "011", -- NOT
        res_addsub when "100", -- ADD
        res_addsub when "101", -- SUB
        res_mul    when "110", -- MUL
        "0000"     when "111", -- COMP
        "0000"     when others;
        
    -- conecta o sinal interno ao pino de saída oficial
    result <= res_int;

    
    
    -- flag Zero
    zero <= '1' when res_int = "0000" else '0';

-- flag Overflow: 
    overflow <= '1' when ( (opcode = "100" or opcode = "101") and 
                           ( (a(3) = '1' and b_addsub(3) = '1' and res_addsub(3) = '0') or 
                             (a(3) = '0' and b_addsub(3) = '0' and res_addsub(3) = '1') ) ) 
                else '0';

    -- flag CarryOut
    cout <= cout_addsub when (opcode = "100" or opcode = "101") else '0';
    
    -- flags do Comparador
    equ <= eq_int when opcode = "111" else '0';
    grt <= grt_int when opcode = "111" else '0';
    lst <= lst_int when opcode = "111" else '0';
end architecture estrutural;