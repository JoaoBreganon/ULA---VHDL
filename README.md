# Unidade Lógica e Aritmética (ULA) de 4 Bits em VHDL

Este projeto consiste no desenvolvimento completo de uma **Unidade Lógica e Aritmética (ULA) de 4 bits** descrita em VHDL e voltada para síntese em FPGAs (com suporte para a família Altera/Intel Cyclone IV). O projeto adota uma abordagem estritamente estrutural e modular (Bottom-Up), dividindo o sistema em componentes fundamentais reaproveitáveis que se conectam em um bloco central integrado a displays de 7 segmentos e LEDs de sinalização física.

---

## 📌 Funcionalidades e Conjunto de Instruções (Opcodes)

A ULA processa dois vetores de entrada de 4 bits ($A$ e $B$) com base em um seletor de operação de 3 bits (`Opcode`), gerando um barramento de resultado de 4 bits (`Result`) e 6 flags de status.

| Opcode | Operação | Descrição | Comportamento das Saídas |
| :---: | :---: | :---: | :--- |
| **000** | `nop` | Nenhuma Operação | `Result = "0000"` e todas as flags de status zeradas (`0`). |
| **001** | `and` | AND Bit a Bit | Realiza a conjunção lógica entre as entradas $A$ e $B$. |
| **010** | `or` | OR Bit a Bit | Realiza a disjunção lógica entre as entradas $A$ e $B$. |
| **011** | `not` | NOT de $B$ | Inverte todos os bits do operando $B$ (Complemento de 1). |
| **100** | `add` | Adição | Realiza a soma aritmética $A + B$ via Somador Ripple Carry. |
| **101** | `sub` | Subtração | Realiza a subtração aritmética $A - B$ usando a lógica de **Complemento de 2** ($A + \overline{B} + 1$). |
| **110** | `mul` | Multiplicação | Multiplica os 2 bits menos significativos de $A$ e $B$ ($A_{1:0} \times B_{1:0}$), gerando um produto de 4 bits. |
| **111** | `comp` | Comparação | Ativa as flags geométricas dedicadas de comparação sem alterar o barramento principal de `Result`. |

---

## 🚦 Flags de Status (Sinalização por LEDs)

A ULA disponibiliza 6 saídas de monitoramento em tempo real para controle de fluxo e verificação aritmética:

1. **Zero (`zero`):** Fica em nível alto (`1`) sempre que o barramento `Result` for exatamente igual a `"0000"`.
2. **Overflow (`overflow`):** Ativada (`1`) quando ocorre um estouro de capacidade aritmética em operações com sinal (Complemento de 2) durante a adição ou subtração (ex: somar dois positivos e obter um resultado negativo).
3. **CarryOut (`cout`):** Indica o transporte de saída do MSB do somador aritmético de 4 bits nas operações de `add` e `sub`.
4. **Igual (`Equ`):** Ativada (`1`) se $A = B$ quando o `Opcode` for `111`.
5. **Maior Que (`Grt`):** Ativada (`1`) se $A > B$ quando o `Opcode` for `111`.
6. **Menor Que (`Lst`):** Ativada (`1`) se $A < B$ quando o `Opcode` for `111`.

---

## 📂 Estrutura de Arquivos do Projeto

O design foi concebido de forma modular. Abaixo está a descrição da árvore de arquivos e hierarquia:

* **`package projeto1.vhd` (Component Package):** Contém as declarações dos componentes (`somador_completo`, `somador_4bits`, `multiplicador`, `comparador_4bits`) para permitir a instanciação limpa em qualquer ponto do projeto.
* **`somador_completo_projeto1.vhd`:** Implementação em nível de portas lógicas de um somador completo de 1 bit (Full Adder).
* **`somador_4bits.vhd`:** Instanciação estrutural em cascata de 4 somadores de 1 bit, formando um somador Ripple Carry completo.
* **`multiplicador.vhd`:** Multiplicador combinatório de 2 bits $\times$ 2 bits baseado na geração de produtos parciais e soma simultânea via portas lógicas.
* **`comparador_4bits.vhd`:** Circuito combinatório paralelo bit a bit que avalia magnitude e igualdade entre dois vetores de 4 bits.
* **`ula.vhd`:** Unidade central da ULA. Contém as portas lógicas nativas para AND, OR e NOT, a lógica de Complemento de 2 para o bloco subtrator, e o multiplexador de saída baseado no `Opcode`.
* **`top_entity.vhd` (Top-Level):** Módulo superior que realiza a interface com o hardware físico da FPGA. Ele instancia a ULA principal e incorpora uma **função decodificadora interna** responsável por converter os sinais binários em código de sete segmentos para os displays da placa.

---

## 🛠️ Mapeamento de Pinos na Placa FPGA (Cyclone IV)

O projeto está totalmente compatível com o mapeamento físico exigido, associando as chaves estáticas (*Switches*), Displays de 7 Segmentos e LEDs de alto brilho:

### Entradas (Chaves)
* **Entrada A:** `SW10` a `SW7` (Representa o vetor de 4 bits de A)
* **Entrada B:** `SW6` a `SW3` (Representa o vetor de 4 bits de B)
* **Seletor (Opcode):** `SW2` a `SW0` (Controle da Operação)

### Saídas Físicas (Displays de 7 Segmentos - Lógica Inversa)
* **`HEX4`:** Exibe o caractere hexadecimal correspondente ao valor de entrada **A**.
* **`HEX2`:** Exibe o caractere hexadecimal correspondente ao valor de entrada **B**.
* **`HEX0`:** Exibe o valor do **Opcode** atual selecionado pelas chaves.
* **`HEX6`:** Exibe o caractere hexadecimal correspondente ao **Result** gerado pela ULA.

### Sinalização Visual (LEDs Vermelhos)
* `LEDR0` $\rightarrow$ **Cout**
* `LEDR1` $\rightarrow$ **Zero**
* `LEDR2` $\rightarrow$ **Overflow**
* `LEDR3` $\rightarrow$ **Equ**
* `LEDR4` $\rightarrow$ **Grt**
* `LEDR5` $\rightarrow$ **Lst**

---

## 🧪 Metodologia de Simulação (Testbenches)

Para validar a integridade do circuito antes da gravação em hardware, o projeto deve ser simulado no **ModelSim** em uma abordagem progressiva de baixo para cima (Bottom-Up):

1.  **`somador_completo_tb_projeto1.vhd`:** Validação exaustiva das 8 combinações de tabela verdade para o Full Adder de 1 bit.
2.  **`somador_4bits_tb.vhd`:** Loop duplo aninhado testando dinamicamente todas as 256 combinações possíveis para as entradas com $Cin = '0'$ e $Cin = '1'$.
3.  **`multiplicador_tb.vhd`:** Cobertura de todas as combinações de multiplicação entre barramentos de 2 bits.
4.  **`comparador_4bits_tb.vhd`:** Varredura completa para comprovar a transição das saídas de magnitude (Maior, Menor, Igual).
5.  **`ula_tb.vhd`:** Teste final integrado simulando as mudanças de contexto do `Opcode` com cargas de dados específicas para forçar o acendimento de cada flag (incluindo geração induzida de overflow e carry out).

---

## 🚀 Como Compilar e Executar no Quartus Prime

1. Abra o **Quartus Prime** e crie um novo projeto com o nome de revisão exatamente como `Ula`.
2. Certifique-se de que o dispositivo selecionado seja compatível com a sua placa (ex: **Cyclone IV E - EP4CE115F29C7**).
3. Adicione todos os arquivos `.vhd` listados na seção de estrutura ao projeto.
4. Defina o arquivo `top_entity.vhd` como a **Top-Level Design Entity** (*Assignments > Settings > General*).
5. Abra o **Pin Planner** (*Assignments > Pin Planner*) e preencha a coluna *Location* com os códigos de pinos correspondentes aos Switches, LEDs e Displays da sua placa.
6. Vá em *Assignments > Settings > EDA Tool Settings > Simulation*, configure o diretório de saída como `simulation/modelsim/` para evitar conflitos de permissão no Windows.
7. Execute o processo **Start Compilation**.
8. Conecte a placa FPGA via cabo USB, ligue a chave geral, abra o **Programmer**, certifique-se de que o **USB-Blaster** está selecionado no *Hardware Setup*, adicione o arquivo gerado `Ula.sof` e clique em **Start** para efetuar o upload do hardware.
