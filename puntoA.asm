#Encontrar la posici�n del valor m�ximo en el arreglo .
.data 
	arreglo: .word 20, 1, 2, 3, 4, 5, 6, 7, 8, 22, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
	contador: .word 0
	tama�o_arreglo: .word 20
	print_resultado: .asciiz "El valor maximo en el  arreglo es: "
	print_posicion: .asciiz "La posicicion del valor maximo es: "
	print_arreglo: .asciiz "El arreglo utilizado es el siguiente: "
	nueva_linea: .asciiz "\n"
	coma: .asciiz ", "
	abrir_corchete: .asciiz "["
	cerrar_corchete: .asciiz "]"
		
.text
	la $t1, arreglo
	lw $s1, arreglo
	lw $s2, contador
	lw $t2, tama�o_arreglo
	li $t4, 0
	encontrar:
	
	sll $s3, $s2, 2 #Se multiplica el contador por 4.
	add $s4, $t1, $s3 #Sumo el contador a la direcci�n del arreglo (es como hacer A[contador])
	lw $s5, ($s4)#Cargo el valor de A[contador] en s5.
	addi $s2, $s2, 1 #Sumo uno al contador para seguir iterando, es como en un while.
	

	bge $s2, $t2, guardar #Si el contador es igual o mayor al tama�o del arreglo detengo el bucle.
	bgt $s5, $s1, cambiar #Si el valor de A[contador] es mayor al elemento mas grande, cambio.
	
	j encontrar #Vuelve al comienzo del bucle.
	
	cambiar:
	
	move $s1, $s5 #Muevo el A[contador] a la variable donde est� el elemento mas grande.

	subi $t5, $s2, 1 #Resto uno al �ndice actual.
	move $t4, $t5 #guardo la posici�n del �ndice actual menos uno.
	
	
	j encontrar #Vuelvo al bucle.
	
	
	guardar:

	sw $s1, -4($t1) #Guardo el resultado en la  direcci�n anterior al primer elemento del arreglo.
	sw $t4, -8($t1) #Guardo la posici�n del resultado en la direcci�n anterior.
	
	#Desde aca se empieza a mostrar el resultado.
	
	mostrar:
	
	li $v0, 4
	la $a0, print_resultado
	syscall
	
	li $v0, 1
	lw $a0, -4($t1)
	syscall
	
	li $v0, 4
	la $a0, nueva_linea
	syscall
	
	li $v0, 4
	la $a0, print_posicion
	syscall
	
	li $v0, 1
	lw $a0, -8($t1)
	syscall
	
	li $v0, 4
	la $a0, nueva_linea
	syscall
	
	li $v0, 4
	la $a0, print_arreglo
	syscall
	
	li $t3, 0
	
	#Esta funci�n es para imprimir el arreglo por consola
	
	mostrar_arreglo:
	

    	# Imprimir el primer corchete
    	li $v0, 4
    	la $a0, abrir_corchete
    	syscall

    	# Iterar sobre el arreglo
    	li $t3, 0  # Reiniciar el contador de posici�n del arreglo
    	li $t4, 0  # Reiniciar el flag para imprimir coma
    	li $t5, 4  # Tama�o de una palabra en bytes

	iterar_arreglo:
    	# Calcular la direcci�n del elemento actual del arreglo
    	mul $t6, $t3, $t5
    	add $t7, $t1, $t6

    	# Cargar el elemento actual del arreglo
    	lw $a0, ($t7)
    	li $v0, 1
    	syscall

    	# Imprimir coma si no es el �ltimo elemento
    	addi $t3, $t3, 1
    	bne $t3, $t2, imprimir_coma

    	# Imprimir el �ltimo corchete y saltar al finalizar
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
   	
   	li $v0, 10
   	syscall #Fin del programa