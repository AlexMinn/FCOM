#Alejandro Miñambres y Miguel Garcia de Pedro
.data
A: .asciiz   "Hola Mundo"
B: .space 64
C: .space 64
D: .word 0
.text 
main:
	la $s0 A		#s0 posicion cadena A
	la $s1 B		#s1 posicion cadena B
	la $s2 C		#s2 posicion cadena C
	la $s5 D		#s5 posicion cadena D 
	
	add $t1,$s0,$zero	#t1 posicion cadena
	addi $t2,$zero,32	#t2 es 32 en codigo ascci espacio
	addi $t0,$zero,0	#dejamos t0 a 0
	
esp:	addi $s6,$s6,1
bucle: 	lb $t3, 0($t1)
	addi $t1,$t1,1		 
	addi $s3,$s3,1
	beq $t2, $t3, esp	#si t2 es igual a t3 suma una palabra	
	bne $t3, $t0, bucle 	#si s1 es igual 0 se acaba
	addi $s3,$s3,-1		#s3 longitud de la cadena
	
	addi $s6,$s6,48
	sb $s6, 0($s5)
	addi $t0,$zero,1
	and $s4, $t0,$s3	#1 si es impar 0 si es par
	addi $s3,$s3,-1		#la longitud es uno menos pq empieza en 0
	
	add $t0, $s0, $s3
	add $t0, $t0, $s4
	addi $t0,$t0,-1		#t0 con valor para empezar en impar
impar:	lb $t1, 0($t0)
	sb $t1, 0($s1)
	addi $t0,$t0,-2
	addi $s1,$s1,1
	bne $t0,$s0 ,impar
	lb $t1, 0($t0)
	sb $t1, 0($s1)
		
	add $t0, $s0, $s3	
	sub $t0,$t0,$s4		#t0 valor para empezar en par
	addi $s0,$s0,1		#cambio valor para no salirme de rango 
par:	lb $t1, 0($t0)
	sb $t1, 0($s2)
	addi $t0,$t0,-2
	addi $s2,$s2,1
	bne $t0,$s0 ,par
	lb $t1, 0($t0)
	sb $t1, 0($s2)	
	
	li $v0, 10
	syscall
	
	
		
	
	
