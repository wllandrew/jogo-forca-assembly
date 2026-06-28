jmp main

; Variáveis 

; Endereço das palavras e palavras 
palavra0: string "oi"
palavra1: string "pisca"
palavra2: string "sucesso"
palavra3: string "banana"
palavra4: string "livro"
palavra5: string "verdade"
palavra6: string "falso"
palavra7: string "estudo"
palavra8: string "testar"

; Banco de palavras 
palavras: var #9
    static palavras + #0, #palavra0
    static palavras + #1, #palavra1
    static palavras + #2, #palavra2
    static palavras + #3, #palavra3
    static palavras + #4, #palavra4
    static palavras + #5, #palavra5
    static palavras + #6, #palavra6
    static palavras + #7, #palavra7
    static palavras + #8, #palavra8
  
; Palavra digitada
Resultado: var #7
    static Resultado + #0, #0
    static Resultado + #1, #0
    static Resultado + #2, #0
    static Resultado + #3, #0
    static Resultado + #4, #0
    static Resultado + #5, #0
    static Resultado + #6, #0

; Letras testadas para imprimir na tela
Digitada: var #26
    static Digitada + #0, #0
    static Digitada + #1, #0
    static Digitada + #2, #0
    static Digitada + #3, #0
    static Digitada + #4, #0
    static Digitada + #5, #0
    static Digitada + #6, #0
    static Digitada + #7, #0
    static Digitada + #8, #0
    static Digitada + #9, #0
    static Digitada + #10, #0
    static Digitada + #11, #0
    static Digitada + #12, #0
    static Digitada + #13, #0
    static Digitada + #14, #0
    static Digitada + #15, #0
    static Digitada + #16, #0
    static Digitada + #17, #0
    static Digitada + #18, #0
    static Digitada + #19, #0
    static Digitada + #20, #0
    static Digitada + #21, #0
    static Digitada + #22, #0
    static Digitada + #23, #0    
    static Digitada + #24, #0    
    static Digitada + #25, #0
        
pontdigitada: var #1

; FlagIguais
FlagIguais: var #7
    static FlagIguais + #0, #0
    static FlagIguais + #1, #0
    static FlagIguais + #2, #0
    static FlagIguais + #3, #0
    static FlagIguais + #4, #0
    static FlagIguais + #5, #0
    static FlagIguais + #6, #0

restart: var #1

perdeu: var #1

tamanhopalavra: var #1

main:
    loadn r1, #tela_l00     ;Endereco onde comeca a primeira linha do cenario
    loadn r2, #30720       ;cor cinza
    call ImprimeTela

    loadn r2, #0                ;inicializa o contador com 0 

    Loopmenu:
        inchar r4
        loadn r1, #13           ;tecla enter
        
        inc r2                  ;faz a soma aleatória para dar o rand

        cmp r4, r1
        jne Loopmenu

        loadn r5, #9           ;limita o valor para ficar entre 0 e 8
        mod r3, r2, r5

        loadn r0, #palavras
        add r0, r0, r3
        loadi r1, r0        ; pega endereço da palavra
        
        store restart, r1 ; tive que criar essa variável para fazer o restart funcionar e não alterar a lógica do código
        
    Restart:
        call ApagaTela 
        
        call Tamanho 
         
        call Zera
        
        call ImprimeTraco

        load r7, restart ; guarda em r7 o endereço da palavra-alvo (NÃO USAR O R7)
        
        Loopmain:
            call DesenhaBoneco
            
            call Jogo
            
            ; Imprime o Resultado

            loadn r1, #Resultado
            loadn r0, #406     
            loadn r2, #0         ; cor

            call ImprimeResultado
            
            ; Imprime as letras digitas
            
            loadn r1, #Digitada
            loadn r0, #104    
            loadn r2, #256         ; cor

            call ImprimeStr            
            
            call Ganha ; função para ver se a pessoa ganhou o jogo 
            
            jmp Loopmain
            
;--------------------------------------------
;                 Zera
;--------------------------------------------
Zera:
    push r0
    push r1
    push r2
    push r3
        loadn r0, #0
        
        ; Zerar os ponteiro e perdeu
        store pontdigitada, r0
        store perdeu, r0
        
        ; Zerar Resultado
        loadn r1, #7 ; critério de parada
        loadn r2, #0 ; contador
        
        loopR:
            loadn r3, #Resultado
            add r3, r3, r2 ; endereço Resultado[r2]
            storei r3, r0
            
            inc r2            
            cmp r2, r1
            jne loopR
            
            
        ; Zerar Digitada
        loadn r1, #26 ; critério de parada
        loadn r2, #0 ; contador
        
        loopD:
            loadn r3, #Digitada
            add r3, r3, r2
            storei r3, r0
            
            inc r2            
            cmp r2, r1
            jne loopD
            
        ; Zerar Flags
        loadn r1, #7 ; critério de parada
        loadn r2, #0 ; contador
        
        loopF:
            loadn r3, #FlagIguais
            add r3, r3, r2
            storei r3, r0
            
            inc r2            
            cmp r2, r1
            jne loopF
       
    pop r3
    pop r2
    pop r1
    pop r0
    rts
          
;--------------------------------------------
;                 Tamanho
;-------------------------------------------- 
; Tamanho da palavra
Tamanho: 
    push r0
    push r1
    push r2
    push r3
    push r4
    
    ; Precisa saber do tamanho da palavra ainda
    load r0, restart ; tem o endereço da primeira letra da palavra-alvo
    loadn r4, #0 ; vai servir para ser um contador 
    loadn r2, #'\0' ; critério de parada
        
    LoopTamanho:
        loadi r1, r0

        cmp r1, r2
        jeq RtsTamanho

        inc r4
        inc r0

        jmp LoopTamanho
    
    RtsTamanho:
        store tamanhopalavra, r4
        
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        rts

        
;--------------------------------------------
;                  JOGO
;--------------------------------------------
Jogo:
    push r0
    push r1
    push r2

        LoopJogo:
            ; r0 == letra que a pessoa digitar
            inchar r0 ; esperar a pessoa digitar
            
            loadn r1, #65
            cmp r0, r1
            jle nao_maiuscula
            possivel_maiscula:
                loadn r1, #90
                cmp r0, r1
                jgr nao_maiuscula
                loadn r1, #32
                add r0, r0, r1
                
            nao_maiuscula:
            loadn r1, #255 ; A pessoa não escreveu nada
            cmp r1, r0
            jeq LoopJogo
        
        ;r0 tem a letra digitada da pessoa 
        loadn r1, #Digitada
        load r2, pontdigitada
        add r1, r1, r2 ; fica Digitada[pontdigitada]
        storei r1, r0 
        
        ; Atualiza o ponteiro
        inc r2
        store pontdigitada, r2
        
        call Compara

    pop r2
    pop r1
    pop r0
    rts

;--------------------------------------------
;                Compara
;--------------------------------------------
Compara:
    ; r0 tem a letra digitada
    ; r7 tem o endereço 0 da nossa palavra-alvo
    push r1
    push r2
    push r3
    push r4
    push r5

    loadn r3, #0 ; contador
            
    LoopCompara:
        mov r2, r7 ; r2 tem o endereço da primeira letra da palavra-alvo para a gente poder ir mudando
        add r2, r2, r3 ; atualiza o endereço

        loadi r1, r2   ; r1 tem a primeira letra da palavra-alvo
        cmp r1, r0 ; se a letra digitada for uma das letras da palavra-alvo, então
        jeq Continua 
        
        inc r3 ; atualiza o ponteiro

        load r5, tamanhopalavra ; critério de parada para o loop
        cmp r3, r5
        jne LoopCompara

    ; Percorreu a palavra inteira e não achou nada
    ; Só dar o inc no valor do perdeu
    load r4, perdeu
    inc r4
    store perdeu, r4
    
    jmp RtsCompara

    Continua:
        ; r3 tem a posição da letra igual
        loadn r5, #Resultado ; endereço do vetor Resultado
        add r5, r3, r5 ; endereço das Resultado[posição da letra igual]

        storei r5, r0 ; guarda a letra no Resultado[posição da letra igual]
        
        loadn r5, #1
        loadn r4, #FlagIguais
        add r4, r3, r4 ; endereço FlagIguais[posição da letra igual]
        storei r4, r5 ; Liga a flag
        
        LoopContinua: ; Termina de percorrer a palavra para deixar repetir as letras
            inc r3 ; atualiza o ponteiro
            mov r2, r7 ; r2 tem o endereço da primeira letra da palavra-alvo para a gente poder ir mudando
            add r2, r2, r3 ; atualiza o endereço

            loadi r1, r2   ; r1 tem a primeira letra da
            cmp r1, r0 ; se a letra digitada for uma das letras da palavra-alvo, então
            jeq Continua 

            load r5, tamanhopalavra ; critério de parada para o loop
            cmp r3, r5
            jne LoopContinua
            

    RtsCompara:               
        pop r5
        pop r4
        pop r3
        pop r2
        pop r1

        rts

;--------------------------------------------
;                 Ganha
;-------------------------------------------- 
Ganha:
    push r0
    push r1
    push r2
    push r3
    push r4
        
        loadn r0, #FlagIguais
        loadn r1, #0 ; Verifica se a flag está ligada
        loadn r3, #0 ; contador
        load r4, tamanhopalavra ; tamanho da string
        
        LoopGanha:
            loadi r2, r0
            
            cmp r2, r1
            jeq RtsGanha
            
            inc r0
            inc r3
            
            cmp r3, r4
            jne LoopGanha
            
            call Ganhou
    
    RtsGanha:
        pop r4    
        pop r3
        pop r2
        pop r1
        pop r0
        rts
        
;--------------------------------------------
;                 GANHOU
;--------------------------------------------
Ganhou:
    push r0
    push r1
    push r2
    
        call ApagaTela
        
        loadn r1, #tela5Linha0      ;Endereco onde comeca a primeira linha do cenario
        loadn r2, #30720       ;cor cinza
        call ImprimeTela
        
    loadn r2, #0                    ;inicializa o contador com 0 

    loadn r0, #'s'
    loadn r3, #'n'

    LoopGanhou:
        inchar r1                   ;lê o que a pessoa escreveu
    
        inc r2                      ;contador++
    
        cmp r1, r3                  ;se ele digitou 'n'
        jeq Fim

        cmp r1, r0                  ;se ele digitou 's'
        jeq SimG

        jmp LoopGanhou             ;se ele não digitou/digitou outra coisa

    SimG:
        loadn r5, #3               ;tamanho do banco de palavrass
        mod r3, r2, r5              ;deixo o valor entre 0 e 1

        loadn r0, #palavras     ; endereço do banco de palavras
        add r0, r3, r0          ; endereço palavras[r3]
        loadi r1, r0            ; AQUI tem o endereço da palavra-alvo que estava no palavras[r3]
        
        store restart, r1       ; guardei o valor do endereço da palavra-alvo na variável restart

        pop r3
        pop r2
        pop r1
        pop r0
        
        pop r0                      ; mais um r0 para desimpilhar tudo para ir direto na main 

        jmp Restart

    
    pop r2
    pop r1
    pop r0
    rts
    
;--------------------------------------------
;               FRACASSOU
;--------------------------------------------
Fracassou:
    call ApagaTela
        
    loadn r1, #telaFinalPLinha0      ;Endereco onde começa a primeira linha do cenario
    loadn r2, #30720       ;cor cinza
    call ImprimeTela
        
    loadn r2, #0                    ;inicializa o contador com 0 

    loadn r0, #'s'
    loadn r3, #'n'

    LoopFracassou:
        inchar r1                   ;lê o que a pessoa escreveu
    
        inc r2                      ;contador++
    
        cmp r1, r3                  ;se ele digitou 'n'
        jeq Fim

        cmp r1, r0                  ;se ele digitou 's'
        jeq SimF

        jmp LoopFracassou             ;se ele não digitou/digitou outra coisa

    SimF:
        loadn r5, #3               ;tamanho do banco de palavrass
        mod r3, r2, r5              ;deixo o valor entre 0 e 1

        loadn r0, #palavras     ; endereço do banco de palavras
        add r0, r3, r0          ; endereço palavras[r3]
        loadi r1, r0            ; AQUI tem o endereço da palavra-alvo que estava no palavras[r3]
        
        store restart, r1       ; guardei o valor do endereço da palavra-alvo na variável restart

        pop r3
        pop r2
        pop r1
        pop r0
        
        pop r0                      ; mais um r0 para desimpilhar tudo para ir direto na main 

        jmp Restart

;--------------------------------------------
;            Desenha Boneco
;--------------------------------------------
DesenhaBoneco:
    push r0
    push r1
    push r2
    push r3
    push r4
    
    load r0, perdeu ; Quantas partes do boneco tem que desenhar
    
    loadn r1, #0 
    cmp r1, r0
    jeq RtsDesenhaBoneco
    
    ; Para desenhar o boneco, tem que estar entre 1 a 7, se perdeu for 7, então desenha tudo e perde
    ; Tem que desenhar a cabeça
    loadn r2, #'O' ; Caractere da cabeça
    loadn r3, #50  ; Posição na tela
    outchar r2, r3
    
    loadn r1, #1
    cmp r0, r1
    jeq RtsDesenhaBoneco
    
    ; Tem que desenhar o tronco 1
    loadn r2, #'|' 
    loadn r3, #90  ; Posição na tela
    outchar r2, r3
    
    loadn r1, #2
    cmp r0, r1
    jeq RtsDesenhaBoneco
    
    ; Tem que desenhar o braço esquerdo
    loadn r2, #'/' 
    loadn r3, #89  ; Posição na tela
    outchar r2, r3
    
    loadn r1, #3
    cmp r0, r1
    jeq RtsDesenhaBoneco
    
    ; Tem que desenhar o braço direito
    loadn r2, #'>' 
    loadn r3, #91  ; Posição na tela
    outchar r2, r3
    
    loadn r1, #4
    cmp r0, r1
    jeq RtsDesenhaBoneco
    
    ; Tem que desenhar o tronco 2
    loadn r2, #'|' 
    loadn r3, #130  ; Posição na tela
    outchar r2, r3
    
    loadn r1, #5
    cmp r0, r1
    jeq RtsDesenhaBoneco
    
    ; Tem que desenhar o braço esquerdo
    loadn r2, #'/' 
    loadn r3, #169  ; Posição na tela
    outchar r2, r3
    
    loadn r1, #6
    cmp r0, r1
    jeq RtsDesenhaBoneco
    
    ; Tem que desenhar o braço direito
    loadn r2, #'L' 
    loadn r3, #170  ; Posição na tela
    outchar r2, r3
    
    loadn r1, #7
    cmp r0, r1
    ceq Fracassou
    
    RtsDesenhaBoneco:
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        
        rts

;--------------------------------------------
;                 FIM
;--------------------------------------------
Fim:
    ; seria legal uma tela para finalizar o jogo
    halt

;--------------------------------------------
;              Imprime Traço
;--------------------------------------------
ImprimeTraco:
    push r0
    push r1
    push r2
    push r3
    
    loadn r0, #446
    
    loadn r1, #'_'
    
    load r2, tamanhopalavra ; Critério de parada
    
    loadn r3, #0 ; funciona como um contador
    
    LoopT:
        outchar r1, r0
        
        inc r0
        inc r3
        
        cmp r3, r2 ; compara se chegou no tamanho da palavra
        jne LoopT
        
    RtsImprimeTraco:
        pop r3
        pop r2
        pop r1
        pop r0
        rts   
;--------------------------------------------
;            Imprime Resultado
;-------------------------------------------- 
ImprimeResultado:
    ;r0 = Posicao da tela que o primeiro caractere da mensagem será impresso 
    ;r1 = endereco onde comeca a mensagem
    ;r2 = cor da mensagem

    push r0 
    push r1 
    push r2 
    push r3 
    push r4
    push r5
    
    load r3, tamanhopalavra ; Criterio de parada
    loadn r5, #0
    

   LoopImprimeR: 
        loadi r4, r1
        
        cmp r5, r3      ; Se imprimiu tudo, sai
        jeq RtsImprimeResultado
        
        add r4, r2, r4  ; Soma a Cor
        outchar r4, r0  ; Imprime o caractere na tela
        inc r0          ; Incrementa a posicao na tela
        inc r1          ; Incrementa o ponteiro da String
        inc r5
        jmp LoopImprimeR
    
   RtsImprimeResultado: 
    pop r5 
    pop r4  
    pop r3
    pop r2
    pop r1
    pop r0
    rts
    
;--------------------------------------------
;             Imprime Tela
;--------------------------------------------
ImprimeTela:
    ;r1 = endereco onde comeca a primeira linha do Cenario
    ;r2 = cor do Cenario para ser impresso

    push r0 
    push r1 
    push r2 
    push r3 
    push r4
    push r5

    loadn R0, #0    ; posicao inicial tem que ser o comeco da tela!
    loadn R3, #40   ; Incremento da posicao da tela!
    loadn R4, #41   ; incremento do ponteiro das linhas da tela
    loadn R5, #1200 ; Limite da tela!
    
   ImprimeTela_Loop:
        call ImprimeStr
        add r0, r0, r3      ; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
        add r1, r1, r4      ; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
        cmp r0, r5          ; Compara r0 com 1200
        jne ImprimeTela_Loop    ; Enquanto r0 < 1200

    pop r5  
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts
                
;--------------------------------------------
;             Imprime String 
;--------------------------------------------
ImprimeStr:  
    ;r0 = Posicao da tela que o primeiro caractere da mensagem será impresso 
    ;r1 = endereco onde comeca a mensagem
    ;r2 = cor da mensagem

    push r0 
    push r1 
    push r2 
    push r3 
    push r4
    
    loadn r3, #'\0' ; Criterio de parada

   ImprimeStr_Loop: 
        loadi r4, r1
        cmp r4, r3      ; If (Char == \0)  vai Embora
        jeq ImprimeStr_Sai
        add r4, r2, r4  ; Soma a Cor
        outchar r4, r0  ; Imprime o caractere na tela
        inc r0          ; Incrementa a posicao na tela
        inc r1          ; Incrementa o ponteiro da String
        jmp ImprimeStr_Loop
    
   ImprimeStr_Sai:  
    pop r4  
    pop r3
    pop r2
    pop r1
    pop r0
    rts
    

;--------------------------------------------
;                 Apaga Tela
;--------------------------------------------
ApagaTela:
    push r0
    push r1
    
    loadn r0, #1200     ; apaga as 1200 posicoes da Tela
    loadn r1, #' '      ; com "espaco"
    
       ApagaTela_Loop:  ;;label for(r0=1200;r3>0;r3--)
        dec r0
        outchar r1, r0
        jnz ApagaTela_Loop
 
    pop r1
    pop r0
    rts 

;--------------------------------------------
;                   Telas
;--------------------------------------------  
; Menu
tela4Linha0 : string "                                        "
tela4Linha1 : string "                                        "
tela4Linha2 : string "                                        "
tela4Linha3 : string "                                        "
tela4Linha4 : string "    PRESSIONE ENTER PARA TENTAR FUGIR   "
tela4Linha5 : string "              DA FORCA                  "
tela4Linha6 : string "                                        "
tela4Linha7 : string "                 ________               "
tela4Linha8 : string "                 |      |               "
tela4Linha9 : string "                 |      O               "
tela4Linha10: string "                 |     /|l              "
tela4Linha11: string "                 |     / l              "
tela4Linha12: string "                 |                      "
tela4Linha13: string "                 |                      "
tela4Linha14: string "                 |                      "
tela4Linha15: string "                 |                      "
tela4Linha16: string "                 |                      "
tela4Linha17: string "                 |                      "
tela4Linha18: string "                 |                      "
tela4Linha19: string "                 |                      "
tela4Linha20: string "             ____|_____                 "
tela4Linha21: string "                                        "
tela4Linha22: string "                                        "
tela4Linha23: string "                                        "
tela4Linha24: string "                                        "
tela4Linha25: string "                                        "
tela4Linha26: string "                                        "
tela4Linha27: string "                                        "
tela4Linha28: string "                                        "
tela4Linha29: string "                                        "

; Venceu
tela5Linha0 : string "                                        "
tela5Linha1 : string "                                        "
tela5Linha2 : string "            VOCE VENCEU!                "
tela5Linha3 : string "              PARABENS                  "
tela5Linha4 : string "                                        "
tela5Linha5 : string "                 ________               "
tela5Linha6 : string "                 |      |               "
tela5Linha7 : string "                 |                      "
tela5Linha8 : string "                 |                      "
tela5Linha9 : string "                 |                      "
tela5Linha10: string "                 |                      "
tela5Linha11: string "                 |                      "
tela5Linha12: string "                 |                      "
tela5Linha13: string "                 |                      "
tela5Linha14: string "                 |                      "
tela5Linha15: string "                 |                      "
tela5Linha16: string "                 |                      "
tela5Linha17: string "                 |                      "
tela5Linha18: string "                 |                      "
tela5Linha19: string "                 |                      "
tela5Linha20: string "             ____|_____                 "
tela5Linha21: string "                                        "
tela5Linha22: string "                                        "
tela5Linha23: string "                                        "
tela5Linha24: string "                                        "
tela5Linha25: string "                                        "
tela5Linha26: string "                                        "
tela5Linha27: string "   DESEJA JOGAR NOVAMENTE? <s/n>        "
tela5Linha28: string "                                        "
tela5Linha29: string "                                        "

; Tela Perdeu
telaFinalPLinha0  : string "                                        "
telaFinalPLinha1  : string "                                        "
telaFinalPLinha2  : string "                                        "
telaFinalPLinha3  : string "             VOCE PERDEU!               "
telaFinalPLinha4  : string "                                        "
telaFinalPLinha5  : string "              GAME OVER                 "
telaFinalPLinha6  : string "                                        "
telaFinalPLinha7  : string "                                        "
telaFinalPLinha8  : string "   DESEJA JOGAR NOVAMENTE? <s/n>        "
telaFinalPLinha9  : string "                                        "
telaFinalPLinha10 : string "                                        "
telaFinalPLinha11 : string "                  ____                  "
telaFinalPLinha12 : string "                 /    l                 "
telaFinalPLinha13 : string "                |  T T |                "
telaFinalPLinha14 : string "                |   ^  |                "
telaFinalPLinha15 : string "                |  ___ |                "
telaFinalPLinha16 : string "                 l____/                 "
telaFinalPLinha17 : string "                   | |                  "
telaFinalPLinha18 : string "                  /| |l                 "
telaFinalPLinha19 : string "                 / | | l                "
telaFinalPLinha20 : string "                   | |                  "
telaFinalPLinha21 : string "                  /   l                 "
telaFinalPLinha22 : string "                 /     l                "
telaFinalPLinha23 : string "                                        "
telaFinalPLinha24 : string "                                        "
telaFinalPLinha25 : string "                                        "
telaFinalPLinha26 : string "                                        "
telaFinalPLinha27 : string "                                        "
telaFinalPLinha28 : string "                                        "
telaFinalPLinha29 : string "                                        "

tela_l00 : string "========================================"
tela_l01 : string "=       _____                          ="
tela_l02 : string "=       |    | ____   ____   ____      ="
tela_l03 : string "=       |    ||  _ | | ___| |  _ |     ="
tela_l04 : string "=   ..__|    || |_| | |_.  |  |_| |    ="
tela_l05 : string "=   |________||____|.___  | |____|     ="
tela_l06 : string "=                  |_____|             ="
tela_l07 : string "=               ___                    ="
tela_l08 : string "=            __| _|____                ="
tela_l09 : string "=           | __ ||__  |               ="
tela_l10 : string "=          | |_| | | __ |_             ="
tela_l11 : string "=          |____ |.____  |             ="
tela_l12 : string "=               ||     ||              ="
tela_l13 : string "= ___________                          ="
tela_l14 : string "= |_   _____|__________   ____ _____   ="
tela_l15 : string "=  |    ___|  _ |_  __ |_| ___||__  |  ="
tela_l16 : string "=  |     ||  |_| |  | |||  |___ | __ |_="
tela_l17 : string "=  |___  | |____||__|    |___  |____  |="
tela_l18 : string "=      ||                    ||     || ="
tela_l19 : string "=                                      ="
tela_l20 : string "=                                      ="
tela_l21 : string "=                                      ="
tela_l22 : string "=                                      ="
tela_l23 : string "=           Pressione Espaco           ="
tela_l24 : string "=             Para iniciar             ="
tela_l25 : string "=                                      ="
tela_l26 : string "=                                      ="
tela_l27 : string "=                                      ="
tela_l28 : string "=                                      ="
tela_l29 : string "========================================"