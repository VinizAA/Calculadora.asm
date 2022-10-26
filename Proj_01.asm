TITLE Vinícius Afonso Alvarez - RA: 22006181

.model small
.data
    opc_perg DB "Escolha a opcao desejada:$", 10
    opc_soma DB 10, "[1] Adicao$"
    opc_sub DB 10, "[2] Subtracao$"
    opc_mult DB 10, "[3] Multiplicacao$"
    opc_div DB 10, "[4] Divisao$", 10
    escolha DB 10, ">> $"

    num1 DB 10, "Digite o primeiro numero (0 a 9)$"
    num2 DB 10, "Digite o segundo numero (0 a 9)$"

    erro DB 10, "OCORREU UM ERRO, TENTE NOVAMENTE$"
    reinicia DB 10, "Deseja realizar outra operacao?$"
    opc_sim DB 10, "[1] Sim$"
    opc_nao DB 10, "[2] Nao$"

    resultado DB "Resultado = $"
    sinal_sub DB "-$"
    saindo DB 10, "SAINDO...$"

.code
    PULALINHA MACRO
        MOV AH,02
        MOV DL,10
        INT 21h
    ENDM

    ERROR MACRO
        LEA DX, erro
        MOV AH, 09h
        INT 21h
    ENDM

main PROC
    MOV AX, @data
    MOV DS, AX

    MOV DX, 184Fh
    MOV BH, 0Bh
    INT 10h

;INICIO CABEÇALHO
HEAD:
    LEA DX, opc_perg 
    MOV AH, 09h
    INT 21h
    LEA DX, opc_soma
    MOV AH, 09h
    INT 21h
    LEA DX, opc_sub
    MOV AH, 09h
    INT 21h
    LEA DX, opc_mult
    MOV AH, 09h
    INT 21h
    LEA DX, opc_div
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    CMP AL, 27
    JNE continua1
    JMP FIM

 continua1:
    MOV BL, AL
;FIM CABEÇALHO

;INICIO VERIFICA A ESCOLHA
COMEÇO:
    CMP BL, '1'
    JNE n_adição ;se não for igual, verifica o próximo
    CALL adição ;se for igual, chama função
    n_adição:

    CMP BL, '2'
    JNE n_subtração ;se não for igual, verifica o próximo
    CALL subtração ;se for igual, chama função
    n_subtração:
    CMP BL, '3'
    JNE n_multiplicação ;se não for igual, verifica o próximo
    CALL multiplicação ;se for igual, chama função
    n_multiplicação:

    CMP BL, '4'
    JNE n_divisão ;se não for igual, verifica o próximo
    CALL divisão ;se for igual, chama função
    n_divisão: ;se não for igual, dá erro e reinicia
    
    PULALINHA
    ERROR
    PULALINHA
    CALL HEAD ;se deu errado, volta pro cabeçalho
;FIM VERIFICA A ESCOLHA

FIM:
    PULALINHA
    LEA DX, saindo 
    MOV AH, 09h
    INT 21h
    MOV AH, 4ch
    INT 21h    

RECOMEÇO:
    MOV AH, 02h
    MOV DL, 10
    INT 21h
    LEA DX, reinicia
    MOV AH, 09h
    INT 21h
    LEA DX, opc_sim
    MOV AH, 09h
    INT 21h
    LEA DX, opc_nao
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    CMP AL, 27
    JNE continua6
    JMP FIM

 continua6:
    CMP AL, '1'
    JNE FIM
    MOV AH, 02h
    MOV DL, 10
    INT 21h
    MOV AH, 02h
    MOV DL, 10
    INT 21h
    JMP HEAD

main ENDP

;INICIO SOMA
mais PROC 
adição:
;le o primeiro numero
    PULALINHA
    LEA DX, num1
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    AND AL, 0Fh ;transforma em numeral
    MOV BL, AL ;o primeiro numero guardado em BL

;le o segundo numero
    LEA DX, num2
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    AND AL, 0Fh ;transforma em numeral
    MOV BH, AL ;o segundo numero guardado em BH

;imprime o resultado
    PULALINHA
    LEA DX, resultado
    MOV AH, 09h
    INT 21h
    
    ADD BL, BH

    CMP BL, 9
    JLE soma1
    
    XOR AX, AX
    MOV AL, BL
    MOV BL, 10
    DIV BL

    OR AL, 30h
    OR AH, 30h
    MOV BX, AX

    MOV DL, BL
    MOV AH, 02h
    INT 21h

    MOV DL, BH
    MOV AH, 02h
    INT 21h
    JMP RECOMEÇO

soma1:
    OR BH, 30h
    MOV AH, 02h
    MOV DL, BH
    INT 21h
;reinicia
    JMP RECOMEÇO
mais ENDP
;FIM SOMA

;INICIO SUBTRAÇÃO
menos PROC
subtração:
;le o primeiro numero
    PULALINHA
    LEA DX, num1
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    CMP AL, 27
    JNE continua2
    JMP FIM

continua2:
    AND AL, 0FH ;transforma em numeral
    MOV BL, AL ;BL armazena o primeiro numero

;le o segundo numero
    LEA DX, num2
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    CMP AL, 27
    JNE continua3
    JMP FIM

continua3:
    AND AL, 0Fh ;transforma em numeral
    MOV BH, AL ;BH armazena o segundo numero

;imprime o resultado
    PULALINHA
    LEA DX, resultado
    MOV AH, 09h
    INT 21h

    CMP BL, BH
    JL negativo1

    SUB BL, BH

    MOV DL, BL
    OR DL, 30h ;transforma em caracter
    MOV AH, 02h
    INT 21h
    JMP RECOMEÇO

negativo1:
    LEA DX, sinal_sub
    MOV AH, 09h
    INT 21h

    SUB BH, BL
    MOV DL, BH
    OR DL, 30h ;transforma em caracter
    MOV AH, 02h
    INT 21h

;reinicia
    JMP RECOMEÇO
menos ENDP
;FIM SUBTRAÇÃO

;INICIO MULTIPLICAÇÃO
vezes PROC
multiplicação:
;le o primeiro numero
    PULALINHA
    LEA DX, num1
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    CMP AL, 27
    JNE continua4
    JMP FIM

continua4:
    AND AL, 0FH ;transforma em numeral
    MOV BL, AL ;o segundo numero guardado em BL

;le o segundo numero
    LEA DX, num2
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    CMP AL, 27
    JNE continua5
    JMP FIM

continua5:
    AND AL, 0FH ;transforma em numeral
    MOV BH, AL ;o segundo numero guardado em BH

;imprime o resultado
    PULALINHA
    LEA DX, resultado
    MOV AH, 09h
    INT 21h

    XOR DH, DH
    MOV CX, 4
LOOPING:
    SHR BH, 1
    JNC add0
    ADD DH, BL

add0:
    SHL BL, 1
    ADD BH, 0
    JNZ LOOPING
    
    MOV AH, 09h
    INT 21h
    








;reinicia
    JMP RECOMEÇO
vezes ENDP
;FIM MULTIPLICAÇÃO

;INICIO DIVISÃO
dividir PROC
divisão:
    LEA DX, opc_div
    MOV AH, 09h
    INT 21h
    JMP FIM
dividir ENDP
;FIM DIVISÃO

end main
