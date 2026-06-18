jmp main

; ---------------------------------
; Variaveis                       |
; ---------------------------------

SCREEN_SIZE: var #1200
SPACE: var #8

CINZA: var #30720

;----------------------------------
; Inicio                          |
;----------------------------------

palavra0: string "BANANA   "
palavra1: string "CARRO    "
palavra2: string "PORTA    "
palavra3: string "IGREJA   "
palavra4: string "INVERNO  "
palavra5: string "MAR      "
palavra6: string "CODIGO   "
palavra7: string "CERVEJA  "
palavra8: string "BRASIL   "
palavra9: string "CAFE     "


main:

        call limpa_tela
        call inicia_jogo
        call jogo_loop
        call limpa_tela

;----------------------------------
; Funcoes                         |
;----------------------------------

;GERAL

limpa_tela:
        push R1
        push R2
        
        loadn   R1, #0
        loadn   R2, #SCREEN_SIZE
        limpa_tela_loop:
                cmp     R1, R2
                jeg     limpa_tela_final
                loadn   R0, #SPACE
                outchar R0, R1
                inc     R1
                jmp     limpa_tela_loop
        limpa_tela_final:
                pop R2
                pop R1
                rts
                
time_sleep:
        push R0
        push R1
        
        loadn R0, #1000
        loadn R1, #0 
        time_sleep_loop:
                cmp R1, R0
                jeq time_sleep_end
                dec R0
                jmp time_sleep_loop
        time_sleep_end:
                pop R1
                pop R0
                
                inc R7
                rts
        

; INICIALIZACAO

inicia_jogo:
        push R0
        loadn R0, #telainicial0
        loadn R1, #0
        call printa_tela
        
        inicia_jogo_loop:
                inchar R4
                loadn R5, #SPACE
                cmp R4, R5
                call time_sleep
                jeq inicia_jogo_fim
                jmp inicia_jogo_loop
        inicia_jogo_fim:
                call limpa_tela
                pop R0
                rts
                
        
printa_tela:
        ;R0 = Endereco inicial da string
        ;R1 = Cor da impressao

        push R2
        push R3
        push R4
        push R5
        
        loadn R2, #0
        loadn R3, #1200
        loadn R4, #41
        loadn R5, #40 
        
        printa_tela_loop:
                call print_string
                add R0, R0, R4
                add R2, R2, R5
                cmp R2, R3
                jeq printa_tela_fim
                jmp printa_tela_loop
        printa_tela_fim:
                pop R5
                pop R4
                pop R3
                pop R2
                rts
        

print_string:
        ; R0 = Endereco inicial da string
        ; R1 = Cor
        ; R2 = Inicio da linha
        
        push R3
        push R4
        
        loadn R3, #'\0'
        
        printa_string_loop:
                loadi R4, R0
                cmp R4, R3
                jeq printa_string_fim
                
                add R4, R1, R4
                outchar R4, R2
                inc R2
                inc R0
                jmp printa_tela_loop
        printa_string_fim:
                pop R4
                pop R3
                rts

; LOOP

jogo_loop:
        halt
        
printa_forca:
        nop
        
;----------------------------------
; Impressoes prontas              |
;----------------------------------

telainicial0: string "        _____                           "
telainicial1: string "        .    . ____   ____   ____       "
telainicial2: string "        .    ..  _ . . ___. .  _ .      "
telainicial3: string "    ..__.    .  ._. . ._.  .  ._. .     "
telainicial4: string "    .________..____..___  . .____.      "
telainicial5: string "                   ._____.              "
telainicial6: string "                ___                     "
telainicial7: string "             __. _.____                 "
telainicial8: string "            . __ ..__  .                "
telainicial9: string "           . ._. . . __ ._              "
telainicial10:string "           .____ ..____  .              "
telainicial11:string "                ..     ..               "
telainicial12:string "  ___________                           "
telainicial13:string "  ._   _____.__________   ____ _____    "
telainicial14:string "   .    __..  _ ._  __ ._. ___..__  .   "
telainicial15:string "   .     ..  ._. .  . ...  .___ . __ ._ "
telainicial16:string "   .___  . .____..__.    .___  .____  . "
telainicial17:string "       ..                    ..     ..  "
telainicial18:string "                                        "
telainicial19:string "                                        "
telainicial20:string "                                        "
telainicial21:string "                                        "
telainicial22:string "                                        "
telainicial23:string "            Pressione Espaco            "
telainicial24:string "              Para iniciar              "
telainicial25:string "                                        "
telainicial26:string "                                        "
telainicial27:string "                                        "
telainicial28:string "                                        "
telainicial29:string "                                        "

telaganhou0: string "                                        "
telaganhou1: string "                                        "
telaganhou2: string "                                        "
telaganhou3: string "                                        "
telaganhou4: string "                                        "
telaganhou5: string "                                        "
telaganhou6: string "         _  _   __    ___  ____         "
telaganhou7: string "        . .. . .  .  . __..  __.        "
telaganhou8: string "        . .. ..  O .. .__  . _.         "
telaganhou9: string "         .__.  .__.  .___..____.        "
telaganhou10:string "    ___   __   __ _  _  _   __   _  _   "
telaganhou11:string "   . __. . _. .  . .. .. . .  . . .. .  "
telaganhou12:string "  . ._ ..    ..    .. __ ..  O .. .. .  "
telaganhou13:string "   .___.._.._.._.__.._.._. .__. .____.  "
telaganhou14:string "                                        "
telaganhou15:string "                                        "
telaganhou16:string "                                        "
telaganhou17:string "                                        "
telaganhou18:string "                                        "
telaganhou19:string "                                        "
telaganhou20:string "    Pressione Espaco para reiniciar     "
telaganhou21:string "    Pressione Enter para finalizar      "
telaganhou22:string "                                        "
telaganhou23:string "                                        "
telaganhou24:string "                                        "
telaganhou25:string "                                        "
telaganhou26:string "                                        "
telaganhou27:string "                                        "
telaganhou28:string "                                        "
telaganhou29:string "                                        "
 
telaperdeu0: string "                                        "
telaperdeu1: string "                                        "
telaperdeu2: string "                                        "
telaperdeu3: string "                                        "
telaperdeu4: string "                                        "
telaperdeu5: string "                                        "
telaperdeu6: string "         _  _   __    ___  ____         "
telaperdeu7: string "        . .. . .  .  . __..  __.        "
telaperdeu8: string "        . .. ..  O .. .__  . _.         "
telaperdeu9: string "         .__.  .__.  .___..____.        "
telaperdeu10:string "   ____  ____  ____  ____  ____  _  _   "
telaperdeu11:string "  .  _ ..  __..  _ ..    ..  __.. .. .  "
telaperdeu12:string "   . __. . _.  .   . . D . . _. . .. .  "
telaperdeu13:string "  .__.  .____..__._..____..____..____.  "
telaperdeu14:string "                                        "
telaperdeu15:string "                                        "
telaperdeu16:string "                                        "
telaperdeu17:string "                                        "
telaperdeu18:string "                                        "
telaperdeu19:string "                                        "
telaperdeu20:string "    Pressione Espaco para reiniciar     "
telaperdeu21:string "    Pressione Enter para finalizar      "
telaperdeu22:string "                                        "
telaperdeu23:string "                                        "
telaperdeu24:string "                                        "
telaperdeu25:string "                                        "
telaperdeu26:string "                                        "
telaperdeu27:string "                                        "
telaperdeu28:string "                                        "
telaperdeu29:string "                                        "
 
 
stringA0: string " ___ "
stringA1: string ".   ."
stringA2: string ".___."
stringA3: string ".   ."
 
stringB0: string " ___ "
stringB1: string ".   ."
stringB2: string ".___."
stringB3: string ".___."
 
stringC0: string " ___ "
stringC1: string ".    "
stringC2: string ".    "
stringC3: string ".___ "
 
stringD0: string " __  "
stringD1: string ".  . "
stringD2: string ".   ."
stringD3: string ".__. "
 
stringE0: string " ___ "
stringE1: string ".    "
stringE2: string ".___ "
stringE3: string ".___ "
 
stringF0: string " ___ "
stringF1: string ".    "
stringF2: string ".___ "
stringF3: string ".    "
 
stringG0: string " ___ "
stringG1: string ".    "
stringG2: string ". __."
stringG3: string ".___."
 
stringH0: string "     "
stringH1: string ".   ."
stringH2: string ".___."
stringH3: string ".   ."
 
stringI0: string "  .. "
stringI1: string "  .. "
stringI2: string "  .. "
stringI3: string "  .. "
 
stringJ0: string "    ."
stringJ1: string "    ."
stringJ2: string "    ."
stringJ3: string " .__."
 
stringK0: string " . . "
stringK1: string " ..  "
stringK2: string " ..  "
stringK3: string " . . "
 
stringL0: string " .   "
stringL1: string " .   "
stringL2: string " .   "
stringL3: string " .___"
 
stringM0: string ".. .."
stringM1: string ". . ."
stringM2: string ".   ."
stringM3: string ".   ."
 
stringN0: string "..  ."
stringN1: string ". . ."
stringN2: string ".  .."
stringN3: string ".   ."
 
stringO0: string "_____"
stringO1: string ".   ."
stringO2: string ".   ."
stringO3: string ".___."
 
stringP0: string "_____"
stringP1: string ".   ."
stringP2: string ".___."
stringP3: string ".    "
 
stringQ0: string "_____"
stringQ1: string ".   ."
stringQ2: string ". . ."
stringQ3: string ".__.."
 
stringR0: string "_____"
stringR1: string ".   ."
stringR2: string ".___."
stringR3: string "..   "
 
stringS0: string " ____"
stringS1: string ".    "
stringS2: string ".___."
stringS3: string "____."
 
stringT0: string "_____"
stringT1: string "  .  "
stringT2: string "  .  "
stringT3: string "  .  "
 
stringU0: string ".   ."
stringU1: string ".   ."
stringU2: string ".   ."
stringU3: string ".___."
 
stringV0: string ".   ."
stringV1: string ".   ."
stringV2: string ".   ."
stringV3: string " ._."
 
stringW0: string ".   ."
stringW1: string ".   ."
stringW2: string ". . ."
stringW3: string ".. .."
 
;stringX0: string " .  ."
;stringX1: string "  .. "
;stringX2: string "  .. "
;stringX3: string " .  ."
 
stringY0: string " .  ."
stringY1: string "  .. "
stringY2: string "  .. "
stringY3: string "  .. "
 
stringZ0: string "____ "
stringZ1: string "   . "
stringZ2: string "  .  "
stringZ3: string " .___"
 
 
vidas60: string "  __________        "
vidas61: string "  .        .        "
vidas62: string "  .                 "
vidas63: string "  .                 "
vidas64: string "  .                 "
vidas65: string "  .                 "
vidas66: string "  .                 "
vidas67: string "  .                 "
vidas68: string "  .                 "
vidas69: string "  .                 "
vidas610:string "  .                 "
vidas611:string "  .                 "
vidas612:string "  .                 "
vidas613:string "                    "
vidas614:string " Vidas restantes:6  " 
 
vidas50: string "  __________        "
vidas51: string "  .        .        "
vidas52: string "  .       . .       "
vidas53: string "  .       ._.       "
vidas54: string "  .                 "
vidas55: string "  .                 "
vidas56: string "  .                 "
vidas57: string "  .                 "
vidas58: string "  .                 "
vidas59: string "  .                 "
vidas510:string "  .                 "
vidas511:string "  .                 "
vidas512:string "  .                 "
vidas513:string "                    "
vidas514:string " Vidas restantes:5  " 
 
vidas40: string "  __________        "
vidas41: string "  .        .        "
vidas42: string "  .       . .       "
vidas43: string "  .       ._.       "
vidas44: string "  .        .        "
vidas45: string "  .        .        "
vidas46: string "  .        .        "
vidas47: string "  .        .        "
vidas48: string "  .                 "
vidas49: string "  .                 "
vidas410:string "  .                 "
vidas411:string "  .                 "
vidas412:string "  .                 "
vidas413:string "                    "
vidas414:string " Vidas restantes:4  " 
 
vidas30: string "  __________        "
vidas31: string "  .        .        "
vidas32: string "  .       . .       "
vidas33: string "  .       ._.       "
vidas34: string "  .        .        "
vidas35: string "  .        .        "
vidas36: string "  .        .        "
vidas37: string "  .        .        "
vidas38: string "  .         .       "
vidas39: string "  .          .      "
vidas310:string "  .           .     "
vidas311:string "  .                 "
vidas312:string "  .                 "
vidas313:string "                    "
vidas314:string " Vidas restantes:3  " 
 
vidas20: string "  __________        "
vidas21: string "  .        .        "
vidas22: string "  .       . .       "
vidas23: string "  .       ._.       "
vidas24: string "  .        .        "
vidas25: string "  .        .        "
vidas26: string "  .        .        "
vidas27: string "  .        .        "
vidas28: string "  .       . .       "
vidas29: string "  .      .   .      "
vidas210:string "  .     .     .     "
vidas211:string "  .                 "
vidas212:string "  .                 "
vidas213:string "                    "
vidas214:string " Vidas restantes:2  " 
 
vidas10: string "  __________        "
vidas11: string "  .        .        "
vidas12: string "  .       . .       "
vidas13: string "  .       ._.       "
vidas14: string "  .        .        "
vidas15: string "  .        ._____   "
vidas16: string "  .        .        "
vidas17: string "  .        .        "
vidas18: string "  .       . .       "
vidas19: string "  .      .   .      "
vidas110:string "  .     .     .     "
vidas111:string "  .                 "
vidas112:string "  .                 "
vidas113:string "                    "
vidas113:string " Vidas restantes:1  " 
 
vidas00: string "  __________        "
vidas01: string "  .        .        "
vidas02: string "  .       . .       "
vidas03: string "  .       ._.       "
vidas04: string "  .        .        "
vidas05: string "  .   _____._____   "
vidas06: string "  .        .        "
vidas07: string "  .        .        "
vidas08: string "  .       . .       "
vidas09: string "  .      .   .      "
vidas010:string "  .     .     .     "
vidas011:string "  .                 "
vidas012:string "  .                 "
vidas013:string "                    "
vidas014:string " Vidas restantes:0  "