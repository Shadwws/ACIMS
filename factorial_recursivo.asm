.data
	resultado: .word 0
	buscado: .word 6
	
.text
	.global main:

		lw $a0, buscado #Se carga el factorial que se desea encontrar.
		
		jal factorial

		# Para este punto, el resultado ya está almacenado en $v0
	
		sw $v0, resultado
		
		lw $a0, resultado
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall
	
	factorial:
		addi $sp, $sp, -8 # Se reserva memoria en el stack para los casos recursivos.
		sw $ra, 0($sp) # Se guarda la referencia del programa y también los resultados parciales.
		sw $s0, 4($sp) 
	
		#caso base
		
		li $v0, 1  
		beq $a0, 0, fin # Si la entrada es igual a cero termino la recursión
		
		move $s0, $a0 # Si no, copio el valor de la entrada a $s0.
		subi $a0, $a0, 1 #decremento uno a la entrada para lograr el n - 1
		jal factorial
		
		mul $v0, $s0, $v0 #Aca es donde se hace la multiplicación de n * n- 1 y se calcula el factorial.
	
	fin:
		lw $ra, ($sp)
		lw $s0, 4($sp)
		addu $sp, $sp, 8 #Devuelvo la memoria reservada en el stack y regreso al main con el resultado en $v0.
		
		jr $ra
		
		 
	
	
	
	
