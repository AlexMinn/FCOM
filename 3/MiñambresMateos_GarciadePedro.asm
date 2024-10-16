#Alejandro Miñambres Mateos y Miguel Garcia de Pedro
.data 
A: .space 64
.align 2
B: .space 64
.align 2
C: .space 128
.text
	li $v0,8
	li $a1,32
	la $a0, A #lee 15 datos o hasta que se de intro y guarda en cadena
	syscall
	jal ultcadcero	#acabar la cadena en 0
	
	li $v0,8
	li $a1,32
	la $a0, B #lee 15 datos o hasta que se de intro y guarda en cadena
	syscall
	jal ultcadcero	#acabar la cadena en 0
	
	la $a0, A
	la $a1, B
	la $a2, C
	add $v0,$zero,$zero
	jal concatenar
	add $s0,$v0,$zero
	
	la $a0, C
	jal Invertir
	
	add $a0,$zero, 10 #imprime un salto de linea
	li $v0, 11
	syscall
	
	la $a0, C	#posicio de la cadena
	li $v0, 4
	syscall
	
	add $a0,$zero, 32 #imprime un espacio
	li $v0, 11
	syscall
	
	add $a0,$s0,$zero #imprime la longitud de esa cadena
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall		#fin 
	
ultcadcero:
	addi $t1, $zero,10
X:	lb $t0,0($a0)	
	addi $a0,$a0,1
	beq $t0,$zero,N
	bne $t0,$t1, X
N:	addi $a0,$a0,-1
	sb $zero 0($a0)
	jr $ra
concatenar:
M:	lb $t0,0($a0)
	addi $v0, $v0,1
	sb $t0,0($a2)
	addi $a0,$a0,1
	addi $a2,$a2,1
	bne $t0,$zero,M
	addi $v0, $v0,-1
	addi $a2,$a2,-1
Q:	lb $t0,0($a1)
	addi $v0, $v0,1
	sb $t0,0($a2)
	addi $a1,$a1,1
	addi $a2,$a2,1
	bne $t0,$zero,Q
	addi $v0, $v0,-1
	jr $ra

Invertir: 
	add $t0,$a0,$zero
	addi $t1, $zero,0
Z:	lb $t2,0($t0)	
	addi $t0,$t0,1
	bne $t1,$t2, Z
	addi $t0,$t0,-2	#en a0 el 1 digito y en t0 el ultimo digito
Y:	lb $t1, 0($a0)
	lb $t2, 0($t0)
	sb $t1, 0($t0)
	sb $t2, 0($a0)
	addi $a0,$a0,1
	addi $t0,$t0,-1
	slt $t3,$a0,$t0
	bne $t3,$zero,Y	
	jr $ra
	
	
