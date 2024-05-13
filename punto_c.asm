.data
arreglo: .word 4, 8, 9, 1, 6, 12
tamano: .word 7
espacio: .asciiz " "
nueva_linea: .asciiz "\n"

.text
.globl main

main:
    la $s7, arreglo       # Cargar la dirección base del arreglo
    lw $s6, tamano        # Cargar el tamaño del arreglo
    li $t0, 0             # Inicializar el índice del bucle externo
    mul $t9, $s6, 4       # Calcular el desplazamiento máximo del arreglo
    j Bubblesort

Bubblesort:
    li $s1, 0            # Inicializar contador interno
    li $t0, 0            # Inicializar índice externo
    
bucle_externo:
    beq $t0, $s6, fin    # Si el índice externo es igual al tamaño, terminar
    
    li $t1, 0            # Inicializar el índice del bucle interno
    li $t2, 0            # Inicializar el flag de intercambio
    
bucle_interno:
    mul $t3, $t1, 4      # Calcular el desplazamiento
    add $t4, $s7, $t3    # Calcular la dirección del elemento actual
    lw $t5, ($t4)        # Cargar el elemento actual
    lw $t6, 4($t4)       # Cargar el siguiente elemento
    
    ble $t5, $t6, no_swap   # Si el elemento actual es menor o igual que el siguiente, no intercambiar
    jal swap               # Intercambiar los elementos
    li $t2, 1              # Establecer el flag de intercambio a 1
    
no_swap:
    addi $t1, $t1, 1     # Incrementar el índice del bucle interno
    blt $t1, $s6, bucle_interno   # Si no hemos llegado al final del arreglo, continuar el bucle interno
    
    beqz $t2, siguiente_externo  # Si no se realizó ningún intercambio en este paso, continuar con el siguiente índice externo
    addi $s1, $s1, 1     # Incrementar el contador de iteraciones
    blt $s1, $s6, bucle_externo   # Si no hemos completado todas las iteraciones, continuar con el bucle externo

siguiente_externo:
    addi $t0, $t0, 1     # Incrementar el índice del bucle externo
    j bucle_externo

fin:
    j mostrar_arreglo     # Mostrar el arreglo

swap:
    lw $t7, ($t4)        # Guardar el valor del primer elemento
    lw $t8, 4($t4)       # Guardar el valor del segundo elemento
    sw $t8, ($t4)        # Colocar el valor del segundo elemento en la posición del primero
    sw $t7, 4($t4)       # Colocar el valor del primer elemento en la posición del segundo
    jr $ra               # Retornar

mostrar_arreglo:
    li $v0, 4            # Imprimir cadena de espacio
    la $a0, espacio
    syscall

    li $t0, 0            # Inicializar el índice del arreglo

loop_imprimir:
    mul $t1, $t0, 4      # Calcular el desplazamiento
    add $t2, $s7, $t1    # Calcular la dirección del elemento i
    lw $a0, ($t2)        # Cargar el elemento i
    li $v0, 1            # Imprimir el elemento
    syscall
    
    li $v0, 4            # Imprimir cadena de espacio
    la $a0, espacio
    syscall
    
    addi $t0, $t0, 1     # Incrementar el índice i
    blt $t0, $s6, loop_imprimir

    la $a0, nueva_linea  # Imprimir nueva línea
    li $v0, 4
    syscall
    
    j fin_mostrar_arreglo  # Finalizar el programa

fin_mostrar_arreglo:
    li $v0, 10
    syscall               # Fin del programa
