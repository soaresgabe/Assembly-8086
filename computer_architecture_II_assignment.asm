; ASSEMBLY 8086
; Recebe o dia e mês do aniversário e retorna o signo
; 21/03 a 20/04 - Áries
; 21/04 a 20/05 - Touro
; 21/05 a 20/06 - Gêmeos
; 21/06 a 21/07 - Câncer
; 22/07 a 22/08 - Leão
; 23/08 a 22/09 - Virgem
; 23/09 a 22/10 - Libra
; 23/10 a 21/11 - Escorpião
; 22/11 a 21/12 - Sagitário
; 22/12 a 20/01 - Capricórnio
; 21/01 a 19/02 - Aquário
; 20/02 a 20/03 - Peixes
; -----------------------------------------------------------

; Bruna Fernandes Machado e Gabriel Antunes Soares
; 28 de Julho de 2023

; -----------------------------------------------------------
; -----------------------------------------------------------

section     .data                                               ; Variaveis inicializadas

;$-texto = tamanho do texto (variavel)

msg0     db     10,"Bem vindo ao Gabriel Sensitivo! ",10       ; Mensagem de boas vindas  
lsmg0    equ    $-msg0                                      ; Tamanho da mensagem de boas vindas

msg1     db     10,"Deseja saber seu signo? (s/n): ",10
lsmg1    equ    $-msg1

msg2     db     10,"Informe o dia do seu aniversario: ",10
lsmg2    equ    $-msg2

msg3     db     10,"Informe o mes do seu aniversario: ",10
lsmg3    equ    $-msg3

; -----------------------------------------------------------

msg4     db     10,"Seu signo e Aries",10
lsmg4    equ    $-msg4

msg5     db     10,"Seu signo e Touro",10
lsmg5    equ    $-msg5

msg6     db     10,"Seu signo e Gemeos",10
lsmg6    equ    $-msg6

msg7     db     10,"Seu signo e Cancer",10
lsmg7    equ    $-msg7

msg8     db     10,"Seu signo e Leao",10
lsmg8    equ    $-msg8

msg9     db     10,"Seu signo e Virgem",10
lsmg9    equ    $-msg9

msg10     db     10,"Seu signo e Libra",10
lsmg10    equ    $-msg10

msg11     db     10,"Seu signo e Escorpiao",10
lsmg11    equ    $-msg11

msg12     db     10,"Seu signo e Sagitario",10
lsmg12    equ    $-msg12

msg13     db     10,"Seu signo e Capricornio",10
lsmg13    equ    $-msg13

msg14     db     10,"Seu signo e Aquario",10
lsmg14    equ    $-msg14

msg15     db     10,"Seu signo e Peixes",10
lsmg15    equ    $-msg15

; data invalida
msg16     db     10,"Data invalida, tente novamente.",10
lsmg16    equ    $-msg16

; outro signo
msg17     db     10,"Deseja saber o signo de outra pessoa? (s): ",10
lsmg17    equ    $-msg17

; -----------------------------------------------------------
; -----------------------------------------------------------

section     .bss                                                ; Variaveis nao inicializadas
opcao       resb    2                                           ; Variavel para armazenar a opcao escolhida
dia         resb    3                                           ; Variavel para armazenar o dia do aniversario
mes         resb    3                                           ; Variavel para armazenar o mes do aniversario

; -----------------------------------------------------------
section     .text                                               ; Codigo
global      _start                                              ; Ponto de entrada do programa
; -----------------------------------------------------------
_start:                                                         ; Inicio do programa

loop:        
    ; Mostra o menu inicial (printf)

    ; Mostra a mensagem de boas vindas
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg0
    mov     edx,lsmg0
    int     0x80

    ; Mostra a mensagem de deseja saber o signo
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg1
    mov     edx,lsmg1
    int     0x80

    ; Recebe a opcao escolhida
    mov     eax,3
    mov     ebx,0
    mov     ecx,opcao
    mov     edx,2
    int     0x80

    ; O que foi digitado pelo usuário se encontra no byte mais significativo
    mov dl, byte[opcao + 0] ; Pega o primeiro byte da variavel opcao

    ; Verifica se a opcao escolhida foi sim
    cmp     dl, 's'
    je      menu
    ; Verifica se a opcao escolhida foi nao
    cmp     dl, 'n'
    je      fim_true

    ; Se nao for nem sim nem nao, volta para o loop
    jmp     loop

; -----------------------------------------------------------

menu:

_dia:
; -----------------------------------------------------------
; Ler Dia ---------------------------------------------------

    ; Print("Informe o dia do seu aniversario: ")
    ; Mostra a mensagem de informe o dia do aniversario
    mov     eax,4                               ; Avisa que vai escrever algo
    mov     ebx,1                               ; Escrever no console
    mov     ecx,msg2                            ; O que vai escrever = msg2
    mov     edx,lsmg2                           ; Quantos bytes vai escrever = lsmg2 guarda o tamanho da mensagem
    int     0x80                                ; Interrupcao do sistema

    ; Scanf("%d", &dia)
    ; Recebe o dia do aniversario
    mov eax, 3 			                        ; Avisa que vai ler algo
    mov ebx, 0			                        ; Ler do console
    mov ecx, dia 			                    ; Onde vai guardar o que leu = dia
    mov edx, 3			                        ; Quantos bytes vai ler
    int 0x80			                        ; Interrupcao do sistema

    ; Verifica se só deu enter e pede para digitar novamente
    mov al, byte[dia + 0] 		                ; Pega o primeiro byte da variavel dia
    cmp al, 10 		                        	; Verifica se o primeiro byte da variavel dia e igual a 10 (se for, so deu enter)
    je invalido			                        ; Se for, vai para invalido

    ; Verifica se o dia tem um digito
    mov al, byte[dia + 1] 		                ; Pega o segundo byte da variavel dia
    cmp al, 10 		                        	; Verifica se o segundo byte da variavel dia e igual a 10 (se for, o dia tem um digito)
    je  dia_um_digito		                    ; Se for, vai para o dia_um_digito
    jmp dia_dois_digitos		                ; Se nao for, vai para o dia_dois_digitos

dia_um_digito:
    mov al, byte[dia + 0]		                ; Pega o primeiro byte da variavel dia
    sub al, 0x30 			                    ; Subtrai 0x30 para transformar o numero de ASCII para decimal
    cmp al, 1 			                        ; Verifica se o dia e menor que 1
    jl invalido			                        ; Se for, vai para invalido
    jmp salvar_dia		                    	; Pula para salvar_dia

dia_dois_digitos:
    mov al, byte[dia + 0] 		                ; Pega o primeiro byte da variavel dia
    sub al, 0x30 			                    ; Subtrai 0x30 para transformar o numero de ASCII para decimal
    mov bl, 10			                        ; 
    mul bl              		                ; Multiplica por 10 e salva em ax
    mov bl, byte[dia + 1] 		                ; Pega o segundo byte da variavel dia
    sub bl, 0x30 			                    ; Subtrai 0x30 para transformar o numero de ASCII para decimal  (48 em decimal)
    add al, bl 			                        ; Soma o primeiro byte com o segundo byte
    cmp al, 31 			                        ; 
    jnle invalido		                        ; Se o dia for maior que 31, vai para invalido
    cmp al, 1		                        	; 
    jl invalido		                        ; Se o dia for menor que 1, vai para invalido

salvar_dia:
    push ax	    		                        ; Salva o dia na pilha para usar depois e liberar o registrador ax

_mes:  
; -----------------------------------------------------------
; Ler Mês ---------------------------------------------------

    ; Print("Informe o mês do aniversário: ")
    ; Mostra a mensagem de informe o mes do aniversario
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg3
    mov     edx,lsmg3
    int     0x80

    ; Scanf("%d", &mes)
    ; Recebe o mes do aniversario
    mov eax, 3 			                        ; Mesma coisa que o scanf do dia
    mov ebx, 0			                        ; 
    mov ecx, mes 			                    ; 
    mov edx, 3			                        ; 
    int 0x80			                        ; 

    ; Verifica se só deu enter e pede para digitar novamente
    mov al, byte[mes + 0] 		                ;
    cmp al, 10 		                        	;
    je  invalido	                            ;

    ; Verifica se o mes tem um digito
    mov al, byte[mes + 1] 		                ; 
    cmp al, 10 		                        	; 
    je  mes_um_digito		                    ; 
    jmp mes_dois_digitos		                ; 


mes_um_digito:
    mov al, byte[mes + 0]		                ; 
    sub al, 0x30 			                    ; 
    jmp processamento		                    ;

mes_dois_digitos:
    mov al, byte[mes + 0] 		                ; 
    sub al, 0x30 			                    ;  
    mov bl, 10			                        ; 
    mul bl              		                ; 
    mov bl, byte[mes + 1] 		                ; 
    sub bl, 0x30 			                    ; 
    add al, bl 			                        ; 
    cmp al, 12 			                        ; 
    jnle invalido		                        ; Se o mes for maior que 12, pede para digitar novamente
    cmp al, 1		                        	; 
    jl  invalido		                        ; Se o mes for menor que 1, pede para digitar novamente


; -----------------------------------------------------------
processamento:

    ; Pega o dia da Pilha
    pop bx                                      ; Pega o dia da pilha e coloca em bx, bl = dia

    ; Verifica o mes
    cmp     al, 1
    je      janeiro
    cmp     al, 2
    je      fevereiro
    cmp     al, 3
    je      marco
    cmp     al, 4
    je      abril
    cmp     al, 5
    je      maio
    cmp     al, 6
    je      junho
    cmp     al, 7
    je      julho
    cmp     al, 8
    je      agosto
    cmp     al, 9
    je      setembro
    cmp     al, 10
    je      outubro
    cmp     al, 11
    je      novembro
    cmp     al, 12
    je      dezembro

    jmp invalido

; -----------------------------------------------------------
; -----------------------------------------------------------

; verifica o dia pra ver qual dos dois signos do mês é

; dia <= 20 -> Capricornio | dia >= 21 -> Aquario
janeiro:
    cmp     bl, 20
    jle     capricornio
    jmp     aquario

; dia <= 19 -> Aquario | dia >= 20 -> Peixes
fevereiro:
    cmp     bl, 28
    jnle    invalido         ; Se o mes for fevereiro, verifica se o dia é maior que 28 (se for, pede para digitar novamente)

    cmp     bl, 19
    jle     aquario
    jmp     peixes

; dia <= 20 -> Peixes | dia >= 21 -> Aries
marco:
    cmp     bl, 20
    jle     peixes
    jmp     aries

; dia <= 20 -> Aries | dia >= 21 -> Touro
abril:
    cmp     bl, 30
    jnle    invalido         ; Se o mes for março, verifica se o dia é maior que 30 (se for, pede para digitar novamente)

    cmp     bl, 20
    jle     aries
    jmp     touro

; dia <= 20 -> Touro | dia >= 21 -> Gemeos
maio:
    cmp     bl, 20
    jle     touro
    jmp     gemeos

; dia <= 20 -> Gemeos | dia >= 21 -> Cancer
junho:
    cmp     bl, 30
    jnle    invalido         ; Se o mes for junho, verifica se o dia é maior que 30 (se for, pede para digitar novamente)

    cmp     bl, 20
    jle     gemeos
    jmp     cancer    

; dia <= 21 -> Cancer | dia >= 22 -> Leao
julho:
    cmp     bl, 21
    jle     cancer
    jmp     leao

; dia <= 22 -> Leao | dia >= 23 -> Virgem
agosto:
    cmp     bl, 22
    jle     leao
    jmp     virgem

; dia <= 22 -> Virgem | dia >= 23 -> Libra
setembro:
    cmp     bl, 30
    jnle    invalido         ; Se o mes for setembro, verifica se o dia é maior que 30 (se for, pede para digitar novamente)

    cmp     bl, 22
    jle     virgem
    jmp     libra

; dia <= 22 -> Libra | dia >= 23 -> Escorpiao
outubro:
    cmp     bl, 22
    jle     libra
    jmp     escorpiao

; dia <= 21 -> Escorpiao | dia >= 22 -> Sagitario
novembro:
    cmp     bl, 30
    jnle    invalido         ; Se o mes for novembro, verifica se o dia é maior que 30 (se for, pede para digitar novamente)

    cmp     bl, 21
    jle     escorpiao
    jmp     sagitario

; dia <= 21 -> Sagitario | dia >= 22 -> Capricornio
dezembro:
    cmp     bl, 21
    jle     sagitario
    jmp     capricornio

; -----------------------------------------------------------
; Mostra o resultado

aries:
    mov     eax,4               ; Escreve na tela
    mov     ebx,1               ; Saida padrao
    mov     ecx,msg4            ; Mensagem
    mov     edx,lsmg4           ; Tamanho da mensagem
    int     0x80                ; Chama o sistema
    jmp     fim                 ; Pula para o fim

touro:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg5
    mov     edx,lsmg5
    int     0x80
    jmp     fim

gemeos:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg6
    mov     edx,lsmg6
    int     0x80
    jmp     fim

cancer:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg7
    mov     edx,lsmg7
    int     0x80
    jmp     fim

leao:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg8
    mov     edx,lsmg8
    int     0x80
    jmp     fim

virgem:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg9
    mov     edx,lsmg9
    int     0x80
    jmp     fim

libra:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg10
    mov     edx,lsmg10
    int     0x80
    jmp     fim

escorpiao:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg11
    mov     edx,lsmg11
    int     0x80
    jmp     fim

sagitario:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg12
    mov     edx,lsmg12
    int     0x80
    jmp     fim

capricornio:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg13
    mov     edx,lsmg13
    int     0x80
    jmp     fim

aquario:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg14
    mov     edx,lsmg14
    int     0x80
    jmp     fim

peixes:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg15
    mov     edx,lsmg15
    int     0x80
    jmp     fim

; -----------------------------------------------------------

fim:

    ; pergunta se quer saber outro signo
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg17
    mov     edx,lsmg17
    int     0x80

    ; Recebe a opcao escolhida
    mov     eax,3
    mov     ebx,0
    mov     ecx,opcao
    mov     edx,2
    int     0x80

    ; O que foi digitado pelo usuário se encontra no byte mais significativo
    mov dl, byte[opcao + 0] ; Pega o primeiro byte da variavel opcao

    ; Verifica se a opcao escolhida foi sim
    cmp     dl, 's'
    je      menu

; -----------------------------------------------------------
fim_true:
    mov     eax,1    ; termina o programa
    mov     ebx,0    ; codigo de retorno
    int     0x80     ; chama o sistema

; -----------------------------------------------------------

invalido:
    mov     eax,4
    mov     ebx,1
    mov     ecx,msg16
    mov     edx,lsmg16
    int     0x80
    jmp     menu

; -----------------------------------------------------------

; Subrotina: converte_char_para_int
; Entrada:
;   - AL contém o valor em ASCII pra converter
; Saída:
;   - AX contém o valor int convertido | Motivo: AX é o registrador de retorno por padrão
converte_char_para_int:
    sub  al, 0x30  ; Converte o caractere ASCII em um valor numérico
    ret
