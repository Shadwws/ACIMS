#Encontrar la posición del valor máximo en el arreglo .
.data 
	arreglo: .word 57, 102, 209, 64, 30, 147, 122, 215, 33, 78, 183, 97, 138, 62, 175, 40, 93, 117, 21, 9
	contador: .word 0
	tamaño_arreglo: .word 20
	arreglo_ordenado: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	print_resultado: .asciiz "El valor maximo en el  arreglo es: "
	print_posicion: .asciiz "La posicicion del valor maximo es: "
	print_arreglo: .asciiz "El arreglo utilizado es el siguiente: "
	nueva_linea: .asciiz "\n"
	coma: .asciiz ", "
	abrir_corchete: .asciiz "["
	cerrar_corchete: .asciiz "]"
	
	abc: .asciiz "El arreglo ordenado queda: "
	
	ordenar: .asciiz "ordenado es "
		
.text
	la $s0, arreglo_ordenado
	la $t1, arreglo
	lw $s7, arreglo
	lw $t2, tamaño_arreglo
	li $t8, 19
	li $t9, 0
	
	
	mayor:
			
			encontrar:
			#busca en la array
				bge $s2, $t2, guardar #Si el contador es igual o mayor al tamaño del arreglo detengo el bucle
				lw $s5, ($t1)                                  
				ble $s5, $s1, aumento #Si el valor de A[contador] es menor aumenta sin cambiar
			
			cambiar:
			#si es mayor cambia el temporal
				move $s1, $s5 #Muevo el A[contador] a la variable donde está el elemento mas grande.
				move $t4, $s2 #guardo la posición del índice actual menos uno.
			
			aumento:
			#aumenta el contador y avanza en la array
				addi $t1, $t1, 4
				addi $s2, $s2, 1 #Sumo uno al contador para seguir iterando, es como en un while.
			
			
				j encontrar #Vuelvo al bucle.
			
			
			guardar:
			#encontrado se guarda en la 2da array y avanzo
				sw $s1, 0($s0) 	
				
				li $v0, 4
				la $a0, ordenar
				syscall
				
				li $v0, 1
				lw $a0, 0($s0) 
				syscall	
				
				li $v0, 4
				la $a0, nueva_linea
				syscall
				
				li $v0, 4
				la $a0, nueva_linea
				syscall
							
				addi $s0, $s0, 4			
				
				
			mostrar:
			#muestro el valr mas grande actual
				li $v0, 4
				la $a0, print_resultado
				syscall
			
				li $v0, 1
				move $a0, $s1 
				syscall
			
				li $v0, 4
				la $a0, nueva_linea
				syscall
			
				li $v0, 4
				la $a0, print_posicion
				syscall
			
				li $v0, 1
				move $a0, $t4
				syscall
			
				li $v0, 4
				la $a0, nueva_linea
				syscall
				
				
			
			borrar:
			#borro el elemento mayor de la 1ra array
				subi $t1, $t1, 80
				mul $t4, $t4, 4
				add $t1, $t1, $t4
				sw $zero, ($t1)
				lw $s5, ($t1)
				sub $t1, $t1, $t4
				
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
				
				li $v0, 4
				la $a0, nueva_linea
				syscall
				
				j reinicio

			imprimir_coma:
				li $v0, 4
				la $a0, coma
				syscall

				j iterar_arreglo
	
			
				
				
				
			
	reinicio:
		#agrego al contador y reinicio el bucle
			li $s2, 0
			li $t4, 0
			add $t9, $t9, 1
			move $s1, $s5
			ble $t9, $t8, mayor	
	
	mostrar_ordenado:
	
		li $t3, 0
		li $t4, 0 
		li $t5, 4
		subi $s0, $s0, 80
		
		li $v0, 4
		la $a0, abc
		syscall
		
		li $v0, 4
		la $a0, nueva_linea
		syscall
		
		ordenado:
			mul $t6, $t3, $t5
			add $t7, $s0, $t6
			
			lw $a0, ($t7)
			li $v0, 1
			syscall
		
		  	addi $t3, $t3, 1
			bne $t3, $t2, comaas
			
			li $v0, 4
			la $a0, cerrar_corchete
			syscall
			
			j fin_mostrar_arreglo
		
		comaas:
			li $v0, 4
			la $a0, coma
			syscall

			j ordenado
		
	
		fin_mostrar_arreglo:
   		li $v0, 10
   		syscall #Fin del programa



