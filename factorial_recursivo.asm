.data
	resultado: .word 0
	buscado: .word 6
	
.text
	.global main:
		lw $a0, buscado
		
		jal factorial
	
		sw $v0, resultado
		
		lw $a0, resultado
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall
	
	factorial:
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $s0, 4($sp)
	
		#caso base
		
		li $v0, 1
		beq $a0, 0, fin
		
		move $s0, $a0
		subi $a0, $a0, 1
		jal factorial
		
		mul $v0, $s0, $v0
	
	fin:
		lw $ra, ($sp)
		lw $s0, 4($sp)
		addu $sp, $sp, 8
		
		jr $ra
		
		 
	
	
	
	