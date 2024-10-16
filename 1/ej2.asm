.data
f: .word 8
g: .word 2
h: .word 1
.text
	la $s3, f
	la $s4, g
	la $s5, h
	lw $t0, 0($s3)
	lw $t1, 0($s4)
	lw $t2, 0($s5)
	
	add $s3, $t0, $t2
	addi $s3, $s3, -3
	sub $s3, $t1, $s3
	li $v0, 10
	syscall 