#Alejandro Mi�ambres Mateos y Miguel Garcia de Pedro
.data
vector:.space 400
.text
main:	la $s0 vector
	addi $t0, $t0, -5	#vector[0]
	sw $t0, 0($s0)
	addi $t1, $t1, 10	#vector[1]
	sw $t1, 4($s0)
	addi $t2, $t2, -50	#vector[2]
	sw $t2, 8($s0)		
	addi $s1,$s1, 100	#s1 el valor de 100
	addi $s0, $s0,12
	addi $s2,$s2,3		#contador s2 iniciada en 3
	
bucle:	add $s2,$s2,1		#por cada vuelta del bucle s2 aumenta en 1
	addi $s0,$s0,-4
	lw $t0,	0($s0)		#guardamos en t0 el contenido de vector[i-1]
	addi $s0, $s0, -4
	lw $t1,	0($s0)		#guardamos en t1 el contenido de vector[i-2]
	addi $s0, $s0, -4
	lw $t2,	0($s0)		#guardamos en t1 el contenido de vector[i-3]
	add $s3, $t2,$t1
	sub $s3, $s3, $t0
	addi $s0,$s0,12
	sw $s3 , 0($s0)		#guardamos en vector(i) la operacion con loas anteriores
	addi $s0,$s0,4
	bne $s2, $s1, bucle 	#si s2 es igual s1 se acaba
	li $v0, 10
	syscall 