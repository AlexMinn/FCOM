.data
Cad: .space 64
Texto: .asciiz "Introduzaca un numero entero\n"
.text

	#Imprime el texto
	la $a0, Texto
	li $v0, 4
	syscall
	#Coge un numero de teclado y lo guarda en a0
	li $v0,5
	syscall
	add $a0,$v0,$zero
	
	la $a1,Cad
	jal Hexa
	
	la $a0, Cad	#posicio de la cadena
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall		#fin 
	
#funcion convierte un numero en hexadecimal
#parametros a0 el numero y a1 direccion cadena	
Hexa:
	addi $t0,$zero,0		#contador
	addi $t1,$zero,8		#limite
	
Z:	addi $t2,$zero,0xf0000000	#mascara
	and $t2,$a0,$t2			
	srl $t2,$t2,28
	
	addi $t3,$zero,10
	slt $t3,$t2,$t3	
	beq $t3,$zero,X	#si el numero es mayor que 9 salta a x
	addi $t2,$t2,48
	j Y		#saltamos para no entar en X
X:	addi $t2,$t2,87
Y:	
	sb $t2,0($a1)
	addi $a1,$a1,1
	addi $t0,$t0,1
	sll $a0,$a0,4
	bne $t0,$t1,Z
	
	
	jr $ra
