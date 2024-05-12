.data

	arreglo: .word 20, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
	tamaño_arreglo: .word 20
	
	nueva_linea: .asciiz "\n"
	coma: .asciiz ", "
	abrir_corchete: .asciiz "["
	cerrar_corchete: .asciiz "]"
	
.text


	li $t0, 0 #indice
	la $t1, arreglo
	lw $t2, tamaño_arreglo
	sub $t2, $t2, 1
	
	
	reinicio:
		li $t0, 0
		la $t1, arreglo
	
	bucle:
		lw $t3, 0($t1)
		lw $t4, 4($t1)
		
		bge $t3, $t4, aumento
		
		sw $t4, 0($t1) 
		sw $t3, 4($t1)
		
	aumento:
	addi $t0, $t0, 1
	addi $t1, $t1, 4 
	
	bne $t0, $t2, bucle
	
	subi $t2, $t2, 1
	
	bgtz $t2, bucle 
	
	
	
	mostrar_arreglo:
	

    	# Imprimir el primer corchete
    	li $v0, 4
    	la $a0, abrir_corchete
    	syscall

    	# Iterar sobre el arreglo
    	li $t3, 0  # Reiniciar el contador de posición del arreglo
    	li $t4, 0  # Reiniciar el flag para imprimir coma
    	li $t5, 4  # Tamaño de una palabra en bytes

	iterar_arreglo:
    	# Calcular la dirección del elemento actual del arreglo
    	mul $t6, $t3, $t5
    	add $t7, $t1, $t6

    	# Cargar el elemento actual del arreglo
    	lw $a0, ($t7)
    	li $v0, 1
    	syscall

    	# Imprimir coma si no es el último elemento
    	addi $t3, $t3, 1
    	bne $t3, $t2, imprimir_coma

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
   	
