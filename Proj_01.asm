.model small
.data
    esc_perg DB "Escolha a opcao desejada:$", 10
    esc_soma DB 10, "[1] Adicao$"
    esc_sub DB 10, "[2] Subtracao$"
    esc_mult DB 10, "[3] Multiplicacao$"
    esc_div DB 10, "[4] Divisao$", 10
    escolha DB 10, ">>> $"

    num1 DB 10, "Digite o primeiro numero (0 a 9)$"
    num2 DB 10, "Digite o segundo numero (0 a 9)$"

    erro DB 10, "Ocorreu um erro, tente novamente$"

    resultado DB "Resultado = $"

.code
main PROC
    MOV AX, @data
    MOV DS, AX

;INICIO CABEÇALHO
HEAD:
    LEA DX, esc_perg 
    MOV AH, 09h
    INT 21h
    LEA DX, esc_soma
    MOV AH, 09h
    INT 21h
    LEA DX, esc_sub
    MOV AH, 09h
    INT 21h
    LEA DX, esc_mult
    MOV AH, 09h
    INT 21h
    LEA DX, esc_div
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    MOV BL, AL
;FIM CABEÇALHO

;VERIFICA A ESCOLHA
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
    MOV AH, 02h
    MOV DL, 10
    INT 21h
    LEA DX, erro
    MOV AH, 09h
    INT 21h
    MOV AH, 02h
    MOV DL, 10
    INT 21h
    CALL HEAD

mais PROC
adição:
    MOV AH, 02h
    MOV DL, 10
    INT 21h
    LEA DX, num1
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    MOV BL, AL

    LEA DX, num2
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    MOV BH, AL

    MOV AH, 02h
    MOV DL, 10
    INT 21h
    LEA DX, resultado
    MOV AH, 09h
    INT 21h
    ADD BH, BL
    SUB BH, 30h
    MOV DL, BH
    MOV AH, 02h
    INT 21h
    JMP FIM
mais ENDP

menos PROC
subtração:
    MOV AH, 02h
    MOV DL, 10
    INT 21h
    LEA DX, num1
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    MOV BL, AL

    LEA DX, num2
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    MOV BH, AL

    MOV AH, 02h
    MOV DL, 10
    INT 21h
    LEA DX, resultado
    MOV AH, 09h
    INT 21h
    SUB BH, BL
    SUB BH, 30h
    MOV DL, BH
    MOV AH, 02h
    INT 21h
    JMP FIM
menos ENDP

vezes PROC
multiplicação:
    MOV AH, 02h
    MOV DL, 10
    INT 21h
    LEA DX, num1
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    MOV BL, AL
    LEA DX, num2
    MOV AH, 09h
    INT 21h
    LEA DX, escolha
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    JMP FIM
vezes ENDP

dividir PROC
divisão:
    LEA DX, esc_div
    MOV AH, 09h
    INT 21h
    JMP FIM
dividir ENDP

FIM:
    MOV ah, 4ch
    INT 21h    
main ENDP

end main