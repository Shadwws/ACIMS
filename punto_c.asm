.data
	arreglo: .word 20, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
	tamanio_arreglo: .word 20
	i: .word 0
	jt: .word 0
	
	nueva_linea: .asciiz "\n"
	coma: .asciiz ", "
	abrir_corchete: .asciiz "["
	cerrar_corchete: .asciiz "]"
	
.text
	la $t0, arreglo
	lw $s0, tamanio_arreglo
	lw $s1, i
	lw $s2, jt
	
	bucle_externo:
	
	bge $s1, $s0, mostrar_arreglo
	lw $s2, i
	add $s2, $s2, $s1
	sub $s3, $s0, $s1
	subi $s3, $s3, 1
	
	bucle_interno:
	
	bgtz $s3, comparar
	addi $s1, $s1, 1
	j bucle_externo
	
	comparar:
	
	lw $s5, 0($t0)
	lw $s6, 4($t0)
	
	blt $s6, $s5, no_swap
	
	sw $s6, ($t0)
	sw $s5, 4($t0)
	
	no_swap:
	addi $t0, $t0, 8
	subi $s3, $s3, 1
	j bucle_interno
	

	
	
	mostrar_arreglo:
	
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
