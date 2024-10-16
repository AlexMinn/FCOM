.data
a: .word 3
b: .word 4
c: .space 40
.text
	la $s0 a
	la $s1 b
	la $s2 c
	lw $t0, 0($s0)
	lw $t1, 0($s1)
	
	addi $t3, $t1,1
	add $t3, $t0, $t3
	sw $t3, 32($s2)