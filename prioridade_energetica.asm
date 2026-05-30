section .data

    ; ==========================================
    ; Entradas dos Sensores
    ; ==========================================

    sensor_solar          db 0    ; A
    sensor_bateria        db 1    ; B
    sensor_horario_pico   db 1    ; C
    sensor_equipamento    db 1    ; D

    ; ==========================================
    ; Saída
    ; ==========================================

    carga_prioritaria     db 0

    msg db "Resultado S = ", 0
    msg_len equ $ - msg

section .bss
    resultado resb 2

section .text
    global _start

_start:

    ; ==========================================
    ; Leitura dos Sensores
    ; ==========================================

    mov al, [sensor_solar]
    mov bl, [sensor_bateria]
    mov cl, [sensor_horario_pico]
    mov dl, [sensor_equipamento]

    ; ==========================================
    ; S = D AND (A OR (B AND NOT C))
    ; ==========================================

    xor cl, 1          ; NOT C

    mov r8b, bl
    and r8b, cl        ; B AND NOT C

    or r8b, al         ; A OR (...)

    and r8b, dl        ; Resultado final S

    mov [carga_prioritaria], r8b

    ; ==========================================
    ; Converter resultado para ASCII
    ; ==========================================

    add r8b, '0'

    mov [resultado], r8b
    mov byte [resultado + 1], 10

    ; ==========================================
    ; Imprimir mensagem
    ; ==========================================

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg_len
    syscall

    ; ==========================================
    ; Imprimir resultado
    ; ==========================================

    mov rax, 1
    mov rdi, 1
    mov rsi, resultado
    mov rdx, 2
    syscall

    ; ==========================================
    ; Encerrar programa
    ; ==========================================

    mov rax, 60
    xor rdi, rdi
    syscall
