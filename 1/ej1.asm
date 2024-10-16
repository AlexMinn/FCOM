.text
	addi $s3, $s3, 8
	addi $s4, $s4, 2
	addi $s5, $s5, 1
	add $s3, $s3, $s5
	addi $s3, $s3, -3
	sub $s3, $s4, $s3
	li $v0, 10
	syscall 
