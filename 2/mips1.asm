
.data
Vector: .word 1,8,9,10,14,16,23,25,31,32		#109
.text
main: 	addi $s0, $zero,10
	add $s2,$zero,$zero
	add $s3,$zero,$zero
	la $s1, Vector
	
bucle:	sll $t1, $s2, 2
	add $t1,$t1, $s1
	lw $t0, 0($t1)
	add $s3, $s3, $t0
	addi $s2,$s2, 1
	bne $s2, $s0, bucle 
	li $v0, 10
	syscall 
