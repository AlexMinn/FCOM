.data
	i: .word 300
	f: .word
.text 
main:	la $t0 i
	la $t1 f
	lw $s0, 0($t0)
	
	addi $s1, $s1,0
	slti $s2, $s0, 0	#pone 1 si s0 es menor que 0
	sw $s0, 0($t1)
	bne $s2, $s1, menor 	#si s2 es igual s1 se acaba
	li $v0, 10
	syscall 
	
menor:	add $t0, $s0 ,$s0
	sub $t0, $s0, $t0
	sw $t0, 0($t1)