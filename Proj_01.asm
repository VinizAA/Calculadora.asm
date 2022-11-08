TITLE Vinícius Afonso Alvarez - RA: 22006181

.model small
.data
    calc DB "                         CALCULADORA - ASSEMBLE$", 13
    obs DB 10, "--> A qualquer momento, se desejar sair da calculadora, pressione 'ESC'$", 13
    opc_perg DB 10, "Escolha a operacao desejada:$", 13
    opc_soma DB 10, "[1] Adicao$", 13
    opc_sub DB 10, "[2] Subtracao$", 13
    opc_mult DB 10, "[3] Multiplicacao$", 13
    opc_div DB 10, "[4] Divisao$", 13
    escolha DB 10, ">> $", 13

    num1 DB 10, "Digite o primeiro numero (0 a 9)$", 13
    num2 DB 10, "Digite o segundo numero (0 a 9)$", 13
    quoc DB 10, "Quociente = $", 13
    rest DB 10, "Resto = $", 13

    erro DB 10, "O SEGUNDO NUMERO DIGITADO NAO E VALIDO, TENTE NOVAMENTE$", 13
    errodiv DB 10, 10, "O VALOR DIGITADO EQUIVALE A ZERO, SENDO IMPOSSIVEL REALIZAR A OPERACAO.$"
    errodiv2 DB 10, "POR FAVOR, DIGITE OUTRO VALOR$", 13
    reinicia DB 10, "Deseja realizar outra operacao?$", 13
    opc_sim DB 10, "[1] Sim$", 13
    opc_nao DB 10, "[2] Nao$", 13

    resultado DB 10, "Resultado = $", 13
    resultado2 DB 10, "RESULTADO DA DIVISAO$", 13
    sinal_sub DB "-$"
    saindo DB 10, "FIM DA CALCULADORA$", 13
    saindo2 DB 10, "SAINDO...$", 13

.code
    PULALINHA MACRO ;macro de pular linha
        MOV AH, 02h
        MOV DL, 10
        INT 21h
    ENDM

    LIMPATELA MACRO ;macro para limpar a tela
        MOV AX, 02h
        INT 10h
    ENDM

    ERROR MACRO ;macro de impressão de erro1
        LEA DX, erro
        MOV AH, 09h ;impressão da mensagem 'erro'
        INT 21h
        XOR DX, DX
    ENDM

    ERROR2 MACRO ;macro de impressão de erro2
        LEA DX, errodiv
        MOV AH, 09h ;impressão da mensagem 'errodiv'
        INT 21h
        LEA DX, errodiv2
        MOV AH, 09h ;impressão da mensagem 'errodiv2'
        INT 21h
        PULALINHA ;macro para pular linha
        JMP DIV0 ;pula para o 'DIV0', independentemente 
    ENDM

main PROC 
    MOV AX, @data ;inicialização do @data
    MOV DS, AX

    LIMPATELA ;macro para pular linha
main ENDP

;INICIO CABEÇALHO
CABEÇALHO:
    LEA DX, calc
    MOV AH, 09h ;impressão da mensagem 'opc_perg'
    INT 21h
    PULALINHA ;macro para pular linha
    LEA DX, obs
    MOV AH, 09h ;impressão da mensagem 'opc_perg'
    INT 21h
    PULALINHA ;macro para pular linha
CABEÇALHO2:
    LEA DX, opc_perg
    MOV AH, 09h ;impressão da mensagem 'opc_perg'
    INT 21h
    LEA DX, opc_soma
    MOV AH, 09h ;impressão da mensagem 'opc_soma'
    INT 21h
    LEA DX, opc_sub
    MOV AH, 09h ;impressão da mensagem 'opc_sub'
    INT 21h
    LEA DX, opc_mult
    MOV AH, 09h ;impressão da mensagem 'opc_mult'
    INT 21h
    LEA DX, opc_div
    MOV AH, 09h ;impressão da mensagem 'opc_div'
    INT 21h
    LEA DX, escolha
    MOV AH, 09h ;impressão da mensagem 'escolha'
    INT 21h
    MOV AH, 01h ;leitura da operação desejada
    INT 21h
    CALL CMPESC ;chama o procedimento 'CMPESC'
    MOV BL, AL ;opção selecionada guardada em BL
;FIM CABEÇALHO

;INICIO VERIFICA A ESCOLHA
INÍCIO:
    CMP BL, '1' ;compara com '1'
    JNE n_adição ;se não for igual, verifica o próximo
    CALL mais ;se for igual, chama função
    n_adição:

    CMP BL, '2' ;compara com '2'
    JNE n_subtração ;se não for igual, verifica o próximo
    CALL menos ;se for igual, chama função
    n_subtração:

    CMP BL, '3' ;comapra com '3'
    JNE n_multiplicação ;se não for igual, verifica o próximo
    CALL vezes ;se for igual, chama função
    n_multiplicação:

    CMP BL, '4' ;compara com '4'
    JNE n_divisão ;se não for igual, verifica o próximo
    CALL dividir ;se for igual, chama função
    n_divisão: ;se não for igual, dá erro e reinicia
    
    PULALINHA ;macro para pular linha
    ERROR ;macro para imprimir erro
    PULALINHA ;macro para pular linha
    CALL CABEÇALHO2 ;se deu errado, volta pro 'cabeçalho'
;FIM VERIFICA A ESCOLHA

;INICIO DO RECOMEÇO
RESTART PROC
    PULALINHA ;macro para pular linha
    LEA DX, reinicia
    MOV AH, 09h ;impressão da mensagem 'reinicia'
    INT 21h
    LEA DX, opc_sim
    MOV AH, 09h ;impressão da mensagem 'opc_sim'
    INT 21h
    LEA DX, opc_nao
    MOV AH, 09h ;impressão da mensagem 'opc_nao'
    INT 21h
    LEA DX, escolha
    MOV AH, 09h ;impressão da mensagem 'escolha'
    INT 21h
    MOV AH, 01h ;leitura da operação desejada
    INT 21h
    CALL CMPESC ;chama o procedimento 'CMPESC'
    CMP AL, '1' ;compara com '1'
    JNE compdnv ;se não for igual, pula para 'compdnv'
    LIMPATELA ;macro para limpar a tela
    CALL CABEÇALHO ;se for igual, chama o procedimento CABEÇALHO
compdnv:
    CMP AL, '2' ;compara com '2'
    JE FIM ;se for igual, pula para 'FIM'
    ERROR ;se não for igual, verifica o próximo
    CALL RESTART ;chama o procedimento 'RESTART'
RET
RESTART ENDP
;FIM DO RECOMEÇO

;INICIO DO FIM
FIM PROC
    PULALINHA
    LEA DX, saindo 
    MOV AH, 09h ;impressão da mensagem 'saindo'
    INT 21h
    LEA DX, saindo2
    MOV AH, 09h ;impressão da mensagem 'saindo2'
    INT 21h
    MOV AH, 4Ch ;termina o programa
    INT 21h
FIM ENDP
;FIM DO FIM

;INICIO CMPESC
CMPESC PROC 
    CMP AL, 27 ;compara com o 'ESC'
    JE FIM ;se for igual, termina o programa
RET
CMPESC ENDP
;FIM CMPESC

;INICIO LEITURA DOS NUMEROS
leitnum1 PROC
;le o primeiro numero
    PULALINHA
    LEA DX, num1
    MOV AH, 09h ;impressão da mensagem 'num1'
    INT 21h
    LEA DX, escolha
    MOV AH, 09h ;impressão da mensagem 'escolha'
    INT 21h
    MOV AH, 01h ;leitura do segundo numero
    INT 21h
    CALL CMPESC ;chama o procedimento 'CMPESC'
    AND AL, 0Fh ;transforma em numeral
RET
leitnum1 ENDP
leitnum2 PROC
;le o segundo numero
    LEA DX, num2
    MOV AH, 09h ;impressão da mensagem 'num2'
    INT 21h
    LEA DX, escolha
    MOV AH, 09h ;impressão da mensagem 'escolha' 
    INT 21h
    MOV AH, 01h ;leitura do segundo numero
    INT 21h
    CALL CMPESC ;chama procedimento 'CMPESC'
    AND AL, 0Fh ;transforma em numeral
RET
leitnum2 ENDP
;FIM LEITURA DOS NUMEROS

;INICIO SOMA
mais PROC 
;leitura dos numeros
    CALL leitnum1 ;chama o procedimento 'leitnum1'
    MOV BL, AL ;o primeiro numero guardado em BL
    CALL leitnum2 ;chama o procedimento 'leitnum2'
    MOV BH, AL ;o segundo numero guardado em BH

;imprime o resultado
    PULALINHA
    LEA DX, resultado
    MOV AH, 09h ;impressão da mensagem 'resultado'
    INT 21h
    
    ADD BL, BH ;soma

    CMP BL, 9 ;compara com 9
    JLE soma1 ;se for menor ou igual, pula para 'soma1'

;impressão de dois dígitos
    XOR AX, AX ;limpa AX
    MOV AL, BL
    MOV BL, 10
    DIV BL ;divide AL (resultado) por 10

    OR AL, 30h ;transforma em caracter
    OR AH, 30h ;transforma em caracter
    MOV BX, AX 

    MOV DL, BL 
    MOV AH, 02h ;impressão do primeiro digito
    INT 21h

    MOV DL, BH
    MOV AH, 02h ;impressão do segundo digito
    INT 21h
    JMP RESTART ;pula para o 'RESTART', independentemente

soma1:
    OR BL, 30h ;transforma em caracter
    MOV AH, 02h ;imprime o resultado
    MOV DL, BL
    INT 21h
    JMP RESTART ;pula para 'restart', independentemente

RET
mais ENDP
;FIM SOMA

;INICIO SUBTRAÇÃO
menos PROC
    ;leitura dos numeros
        CALL leitnum1 ;chama o procedimento 'leitnum1'
        MOV BL, AL ;o primeiro numero guardado em BL
        CALL leitnum2 ;chama o procedimento 'leitnum2'
        MOV BH, AL ;o segundo numero guardado em BH

    ;imprime o resultado
        PULALINHA ;macro para pular linha
        LEA DX, resultado
        MOV AH, 09h ;impressão da mensagem 'resultado'
        INT 21h

        CMP BL, BH ;compara os dois numeros
        JL negativo1 ;se BL (primeiro numero) for menor que BH (segundo numero), pula para 'negativo1'

        SUB BL, BH ;se não for menor, retira BH (segundo numero) de BL (primeiro numero)

        MOV DL, BL
        OR DL, 30h ;transforma em caracter
        MOV AH, 02h ;impressão do resultado
        INT 21h
        JMP RESTART ;pula para 'restart', independentemente

    negativo1:
        LEA DX, sinal_sub
        MOV AH, 09h ;impressão da mensagem 'sinal_sub'
        INT 21h

        SUB BH, BL ;retira BL (primeiro numero) de BH (segundo numero)
        MOV DL, BH
        OR DL, 30h ;transforma em caracter
        MOV AH, 02h ;impressão do resultado
        INT 21h
        JMP RESTART ;pula para 'restart', independentemente
RET
menos ENDP
;FIM SUBTRAÇÃO

;INICIO MULTIPLICAÇÃO
vezes PROC
    ;leitura dos numeros
        CALL leitnum1 ;chama o procedimento 'leitnum1'
        MOV BL, AL ;o primeiro numero guardado em BL
        CALL leitnum2 ;chama o procedimento 'leitnum2'
        MOV BH, AL ;o segundo numero guardado em BH

    ;multiplicação
        XOR AH, AH ;limpa AH
        XOR CX, CX ;limpa CX
        CLC ;limpa o carry

    INICIO:
        SHR BH, 1 ;desloca BH para direita 1 vez
        JNC add0 ;se não houver carry (CF=0), pula para add0
        ADD AH, BL

    add0:
        SHL BL, 1 ;desloca BL para direita 1 vez
        ADD BH, 0
        JNZ INICIO ;se BH não for zero, pula para 'INICIO'

        MOV CH, AH ;CH armazena o resultado da multiplicação

    ;imprime o resultado
        PULALINHA ;macro para pular linha
        LEA DX, resultado
        MOV AH, 09h ;impressão da mensagem 'resultado'
        INT 21h

        CMP CH, 9 ;compara com 9
        JLE mult1 ;se for menor ou igual, pula para 'multi1'

    ;imprime dois dígitos
        XOR AX, AX ;limpa AX
        MOV AL, CH
        MOV BL, 10
        DIV BL ;divide AL (resultado) por 10

        MOV CL, AH

        MOV DL, AL 
        OR DL, 30h ;transforma em caracter
        MOV AH, 02h ;impressão do primeiro numero
        INT 21h

        MOV DL, CL
        OR DL, 30h ;transforma em caracter
        MOV AH, 02h ;impressão do segundo numero
        INT 21h
        JMP RESTART ;pula para o 'restart', independentemente

    mult1:
        MOV DL, CH
        OR DL, 30h ;transforma em caracter
        MOV AH, 02h ;impressão do resultado
        INT 21h
        JMP RESTART ;pula para 'restart', independentemente
    RET
vezes ENDP
;FIM MULTIPLICAÇÃO

;INICIO DIVISÃO
dividir PROC
    ;le o primeiro numero
        CALL leitnum1 ;chama o procedimento 'leitnum1'
        MOV BH, AL ;o primeiro numero (dividendo) guardado em BH
    DIV0:
        CALL leitnum2 ;chama o procedimento 'leitnum2'
        MOV BL, AL ;o segundo numero (divisor) guardado em BL

    ;verifica o divisor
        CMP BL, 0 ;compara com 0
        JNE continua0 ;se não for igual, continua para comparar BL
        ERROR2 ;se for igual, imprime a mensagem 'error2'

        continua0:  
        CMP BH, 0 ;compara BH (dividendo) com 0
        JE resul0 ;se for igual, vai para 'resul0'

    ;divisão
        XCHG BH, BL ;BH e Bl trocam de valor
        MOV CX, 9 
        XOR AX, AX ;limpa AX
        MOV AL, BL

    VOLTA:
        SUB AX, BX ;retira BX de AX
        JNS semsin ;se AX não tiver sinal, pula para 'semsin'
        ADD AX, BX ;se AX tiver sinal, soma BX em AX
        MOV DH, 0
        JMP continua ;pula para o 'continua', independentemente

    SEMSIN:
        MOV DH, 01

    CONTINUA:
        SHL DL, 1 ;desloca DL para esquerda 1 vez
        OR DL, DH
        SHR BX, 1 ;desloca Bx para direita 1 vez
        LOOP VOLTA ;pula para 'VOLTA' e decrementa CX
        PULALINHA ;macro para pular linha

        LEA DX, resultado2
        MOV AH, 09h ;impressão da mensagem 'resultado2'
        INT 21h

        MOV CH, DL ;CH recebe o quociente
        MOV CL, AL ;CL recebe o resto

    ;impressão do quociente
        LEA DX, quoc
        MOV AH, 09h ;impressão da mensagem 'quoc'
        INT 21h

        OR CH, 30h ;transforma em caracter
        MOV DL, CH
        MOV AH, 02h ;impressão do quociente
        INT 21h

    ;impressão do resto
        LEA DX, rest
        MOV AH, 09h ;impressão da mensagem 'rest'
        INT 21h

        OR CL, 30h ;transforma em caracter
        MOV DL, CL
        MOV AH, 02h ;impressão do resto
        INT 21H

        JMP RESTART ;pula para o 'RESTART', independentemente

    ;impressão do resultado = 0
    resul0:
        PULALINHA ;macro para pular linha
        LEA DX, resultado
        MOV AH, 09h ;impressão da mensagem 'resultado'
        INT 21h

        MOV DL, 0
        OR DL, 30h ;transforma em caracter
        MOV AH, 02h ;imprime o resultado 0
        INT 21h
        
        JMP RESTART ;pula para o 'RESTART', independentemente
dividir ENDP
;FIM DIVISÃO
end main
