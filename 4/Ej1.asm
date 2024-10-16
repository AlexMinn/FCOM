.data
Texto: .asciiz "Introduzaca un numero entero\n"
.text

	#Imprime el texto
	la $a0, Texto
	li $v0, 4
	syscall
	#Coge un numero de teclado y lo guarda en s0
	li $v0,5
	syscall
	add $s0,$v0,$zero
	
	srl $s0,$s0,4
	
	addi $t0,$zero,15
	and $s0,$s0,$t0
	
	addi $t1,$zero,10
	slt $t0,$s0,$t1	
	beq $t0,$zero,X	#si el numero es mayor que 9 salta a x
	addi $s0,$s0,48
	j Y		#saltamos para no entar en X
X:	addi $s0,$s0,87
Y:	#imprime a0 que es s0
	add $a0,$zero, $s0
	li $v0, 11
	syscall



	li $v0, 10
	syscall		#fin 