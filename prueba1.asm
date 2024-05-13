.data
array:      .word 12, 255, 200, 150, 50, 33, 133, 100, 17, 15, 33, 188, 0, 10, 12, 40, 201, 7, 9, 10
array_size: .word 20
newline:    .asciiz "\n"

nueva_linea: .asciiz "\n"
	coma: .asciiz ", "
	abrir_corchete: .asciiz "["
	cerrar_corchete: .asciiz "]"

.text
.globl main

main:
    # Cargar la dirección base del array en $s7
    la $s7, array
    # Cargar el tamaño del array en $t0
    lw $t0, array_size

    # Calcular el número de iteraciones (n - 1)
    subi $t0, $t0, 1
    
    # Bucle externo para controlar las iteraciones
    outer_loop:
        # Establecer el flag de intercambio en falso
        li $t1, 0
        
        # Establecer el índice inicial de comparación en 0
        li $t2, 0
        
        # Bucle interno para comparar y, si es necesario, intercambiar elementos
        inner_loop:
            # Calcular las direcciones de memoria de los elementos actuales y siguientes
            mul $t3, $t2, 4       # índice actual * 4 (tamaño de una palabra)
            add $t3, $s7, $t3     # Calcular la dirección del elemento actual sumando el desplazamiento al registro base
            mul $t4, $t2, 4       # índice actual * 4 (tamaño de una palabra)
            addi $t4, $t4, 4      # Calcular el desplazamiento para el siguiente elemento
            add $t4, $s7, $t4     # Calcular la dirección del siguiente elemento sumando el desplazamiento al registro base

            # Cargar los elementos actuales y siguientes en $t5 y $t6
            lw $t5, ($t3)        # Cargar el elemento actual
            lw $t6, ($t4)        # Cargar el siguiente elemento

            # Comparar los elementos
            bge $t5, $t6, no_swap # Si el elemento actual es mayor o igual que el siguiente, no se necesita intercambio
            # Intercambiar los elementos
            sw $t6, ($t3)        # Almacenar el siguiente elemento en la posición actual
            sw $t5, ($t4)        # Almacenar el elemento actual en la posición siguiente
            # Establecer el flag de intercambio en verdadero
            li $t1, 1
            
        no_swap:
            # Incrementar el índice
            addi $t2, $t2, 1
            
            # Comprobar si el índice llegó al límite (n - 1)
            blt $t2, $t0, inner_loop

        # Si no hubo intercambios en esta iteración, el array está ordenado
        beqz $t1, end_outer_loop
        
        # Si hubo intercambios, repetir el bucle externo
        j outer_loop

    end_outer_loop:
	
    	# Imprimir el primer corchete
    	li $v0, 4
    	la $a0, abrir_corchete
    	syscall

    	# Iterar sobre el arreglo
    	li $t3, 0  # Reiniciar el contador de posición del arreglo
    	li $t4, 0  # Reiniciar el flag para imprimir coma
    	li $t5, 4  # Tamano de una palabra en bytes

	iterar_arreglo:
    	# Calcular la dirección del elemento actual del arreglo
    	mul $t6, $t3, $t5
    	add $t7, $t0, $t6

    	# Cargar el elemento actual del arreglo
    	lw $a0, ($t7)
    	li $v0, 1
    	syscall

    	# Imprimir coma si no es el último elemento
    	addi $t3, $t3, 1
    	bne $t3, $s0, imprimir_coma

    	# Imprimir el último corchete y saltar al finalizar
    	li $v0, 4
    	la $a0, cerrar_corchete
    	syscall
    	j fin_mostrar_arreglo

	imprimir_coma:
    	li $v0, 4
    	la $a0, coma
    	syscall

    	j iterar_arreglo
   	
   	fin_mostrar_arreglo:   
    
    
