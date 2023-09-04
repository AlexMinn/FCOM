.data
Entra:	.space 1024
Oper:	.space 128
Cad1:	.space 512
Cad2:	.space 512
RESP:	.space 2048

Texto1: .asciiz "len"
Texto2:	.asciiz "lwc"
Texto3:	.asciiz "upc"
Texto4:	.asciiz "cat"
Texto5:	.asciiz "cmp"
Texto6:	.asciiz "chr"
Texto7:	.asciiz "rchr"
Texto8:	.asciiz "str"
Texto9:	.asciiz "rev"
Texto10:.asciiz "rep"
Texton:	.asciiz "ENTRADA INCORRECTA"

Tex:	.asciiz "IGUAL"
Tex1:	.asciiz "MAYOR"
Tex2:	.asciiz "MENOR"
Texv:	.asciiz	""
#.......
.text	#lee datos o hasta que se de intro y guarda en cadena
	li $v0,8
	li $a1,500
	la $a0, Entra 
	syscall
	#divide la cadena
	la $a0,Entra
	la $a1,Oper
	la $a2,Cad1
	la $a3,Cad2
	jal divide
	beq $v0,1,ENTINC
	#len
	la $a0,Oper
	la $a1,Texto1
	jal cmp
	bne $v0,$zero,F1
	la $a0, Cad1
	jal ncarac
	add $a0,$v0,$zero
	la $a1, RESP
	jal nthex
	j PROFIN	
F1:	#lwc
	la $a0,Oper
	la $a1,Texto2
	jal cmp
	bne $v0,$zero,F2
	la $a0,Cad1
	la $a1, RESP
	jal lwc
	j PROFIN	
F2:	#upc
	la $a0,Oper
	la $a1,Texto3
	jal cmp
	bne $v0,$zero,F9
	la $a0,Cad1
	la $a1, RESP
	jal upc
	j PROFIN
F9:	#rev
	la $a0,Oper
	la $a1,Texto9
	jal cmp
	bne $v0,$zero,F3
	la $a0,Cad1
	jal ncarac
	la $a0,Cad1
	la $a1,RESP
	addi $a2,$v0,-1
	jal Invertir
	j PROFIN
	
	#si la cadena2=0 entrada incorrecta
F3:	la $a0,Cad2
	lb $t0,0($a0)
	beq $t0,$zero,ENTINC
	
	
	#cat
	la $a0,Oper
	la $a1,Texto4
	jal cmp
	bne $v0,$zero,F4
	la $a0,Cad1
	la $a1,Cad2
	la $a2, RESP
	jal cat
	j PROFIN
F4:	#cmp
	la $a0,Oper
	la $a1,Texto5
	jal cmp
	bne $v0,$zero,F5
	la $a0,Cad1
	la $a1,Cad2
	jal cmp
	bne $v0, $zero,X1
	la $a0, Tex
	la $a1, Texv
	la $a2, RESP
	jal cat
	j XF
X1:	beq $v0, -1,X2
	la $a0, Tex1
	la $a1, Texv
	la $a2, RESP
	jal cat
	j XF
X2:	la $a0, Tex2
	la $a1, Texv
	la $a2, RESP
	jal cat
XF:	j PROFIN
	#chr
F5:	la $a0,Oper
	la $a1,Texto6
	jal cmp
	bne $v0,$zero,F6
	la $a0,Cad1
	la $a1,Cad2
	jal chr
	add $a0,$v0,$zero
	la $a1,RESP
	jal nthex
	j PROFIN
	#rchr
F6:	la $a0,Oper
	la $a1,Texto7
	jal cmp
	bne $v0,$zero,F7
	la $a0,Cad2
	jal ncarac
	la $a0,Cad1
	la $a1,Cad2
	add $a3,$v0,$zero
	jal rchr
	add $a0,$v0,$zero
	la $a1,RESP
	jal nthex
	j PROFIN
	#str
F7:	la $a0,Oper
	la $a1,Texto8
	jal cmp
	bne $v0,$zero,F8
	la $a0,Cad1
	la $a1,Cad2
	jal str
	add $a0,$v0,$zero
	beq $a0,$zero,strvac
	add $s3,$v0,$zero
	la $a0,Cad1
	jal ncarac
	sub $a0,$s3,$v0
strvac:	la $a1,RESP
	jal nthex
	j PROFIN
	#rep 
F8:	la $a0,Oper
	la $a1,Texto10
	jal cmp
	bne $v0,$zero,ENTINC
	la $a0,Cad2
	la $a1,Cad2
	jal upc
	la $a0,Cad2
	jal hexadec
	beq $v0,$zero,ENTINC
	la $a0,Cad1
	add $a1,$v0,$zero
	la $a2,RESP
	jal rep
	j PROFIN
	#entrada incorrecta
ENTINC:	la $a0, Texton
	la $a1, Texv
	la $a2, RESP
	jal cat

PROFIN:	#imprime lo que tenga RESP
	la $a0, RESP
	li $v0, 4
	syscall
	#fin 
	li $v0, 10
	syscall
	
	
#funcion que divide la cadena que entra a0
#en a1 a2 a3 quitando espacios tabuladores....
divide:	
	add $v0,$zero,$zero
	addi $t1,$zero,32 #codigo ascci espacio
	addi $t2,$zero,09 #codigo ascii tab
	addi $t3,$zero,10 #contrabarra n
	addi $t4,$zero,0 #nulo
	
Pricad:	lb $t0,0($a0)
	addi $a0,$a0,1
	beq $t0,$t1,Esp1
	beq $t0,$t2,Esp1
	beq $t0,$t3,Fin
	beq $t0,$t4,Fin
	sb $t0,0($a1)
	addi $a1,$a1,1
	j Pricad
	
Esp1:	lb $t0,0($a0)
	addi $a0,$a0,1
	beq $t0,$t1,Esp1
	beq $t0,$t2,Esp1
	beq $t0,$t3,Fin
	beq $t0,$t4,Fin
	sb $t0,0($a2)
	addi $a2,$a2,1
	
Segcad:	lb $t0,0($a0)
	addi $a0,$a0,1
	beq $t0,$t1,Esp2
	beq $t0,$t2,Esp2
	beq $t0,$t3,Final
	beq $t0,$t4,Final
	sb $t0,0($a2)
	addi $a2,$a2,1
	j Segcad
	
Esp2:	lb $t0,0($a0)
	addi $a0,$a0,1
	beq $t0,$t1,Esp2
	beq $t0,$t2,Esp2
	beq $t0,$t3,Final
	beq $t0,$t4,Final
	sb $t0,0($a3)
	addi $a3,$a3,1
	
Tercad:	lb $t0,0($a0)
	addi $a0,$a0,1
	beq $t0,$t1,Fin
	beq $t0,$t2,Fin
	beq $t0,$t3,Final
	beq $t0,$t4,Final
	sb $t0,0($a3)
	addi $a3,$a3,1
	j Tercad
	
Fin:	addi $v0,$zero,1
Final:	jr $ra
#funcion que compara a0 con a1
#devuelve -1 si a0 es menor
#0 si es igual y 1 si a0 es mayor
cmp:	
	addi $t0,$zero,1

CMPEQ:	beq $t0,$zero,CMPSAL
	lb $t0,0($a0)
	addi $a0,$a0,1
	lb $t1,0($a1)
	addi $a1,$a1,1
	beq $t0,$t1,CMPEQ
	
CMPSAL:	bne $t0,$t1,CMPDIF
	add $v0,$zero,$zero
	j CMPFIN
CMPDIF:	slt $t2,$t0,$t1
	beq $t2,$zero,A0MAY 	#t0 es mayor 	
	add $v0,$zero,-1
	j CMPFIN
A0MAY:	addi $v0,$zero,1
CMPFIN:	jr $ra
#funcion que recibe la cadena a0 
#devuelve el numero de caracteres en v0
ncarac:
	add $v0,$zero,$zero
ncar:	lb $t0, 0($a0)
	addi $a0,$a0,1
	addi $v0,$v0,1
	bne $t0,$zero,ncar
	addi $v0,$v0,-1
	jr $ra
#funcion que devuelve el numero en hexadecimal
#recibe el numero en a0 y a1 direccion de cadena
nthex:
	addi $t0,$zero,0		#contador
	addi $t1,$zero,8		#limite
	
nthZ:	addi $t2,$zero,0xf0000000	#mascara
	and $t2,$a0,$t2			
	srl $t2,$t2,28
	
	addi $t3,$zero,10
	slt $t3,$t2,$t3	
	beq $t3,$zero,nthX	#si el numero es mayor que 9 salta a x
	addi $t2,$t2,48
	j nthY
nthX:	addi $t2,$t2,87
nthY:	
	sb $t2,0($a1)
	addi $a1,$a1,1
	addi $t0,$t0,1
	sll $a0,$a0,4
	bne $t0,$t1,nthZ

	jr $ra
#funcion que pasa a minusculas
#recibe a0 la cad y a1 la direccion
lwc:	
	addi $t1,$zero,65
	addi $t2,$zero,90
	
lwcot:	lb $t0, 0($a0)
	addi $a0,$a0,1
	slt $t3,$t0,$t1
	beq $t3,$zero,Men91
	j lwcar
Men91:  slt $t3,$t2,$t0
	beq $t3,$zero,lwccm
	j lwcar
lwccm:	addi $t0,$t0,32	
lwcar:	sb $t0,0($a1)
	addi $a1,$a1,1
	bne $t0,$zero,lwcot
	
	jr $ra
#funcion que pasa a mayusculas
#recibe a0 la cad y a1 la direccion
upc:	
	addi $t1,$zero,97
	addi $t2,$zero,122
	
upcot:	lb $t0, 0($a0)
	addi $a0,$a0,1
	slt $t3,$t0,$t1
	beq $t3,$zero,men123
	j upcar
men123:  slt $t3,$t2,$t0
	beq $t3,$zero,upccm
	j upcar
upccm:addi $t0,$t0,-32	
upcar:	sb $t0,0($a1)
	addi $a1,$a1,1
	bne $t0,$zero,upcot
	
	jr $ra
#funcion que concatena
#recibe a0 cad1 a1 cad2 y a2 la cadena final
cat:
	add $v0,$zero,$zero
catm:	lb $t0,0($a0)
	addi $v0, $v0,1
	sb $t0,0($a2)
	addi $a0,$a0,1
	addi $a2,$a2,1
	bne $t0,$zero,catm
	addi $v0, $v0,-1
	addi $a2,$a2,-1
catq:	lb $t0,0($a1)
	addi $v0, $v0,1
	sb $t0,0($a2)
	addi $a1,$a1,1
	addi $a2,$a2,1
	bne $t0,$zero,catq
	addi $v0, $v0,-1
	jr $ra
#funcion que devuelve el lugar del 1 carac la primera cadena en la segunda
#recibe en a0 la 1 cadena en a1 la 2 cadena y devuelve v0 el numero	
chr:
	add $v0,$zero,$zero
	lb $t1, 0($a0)
chro:	lb $t2, 0($a1)
	addi $a1,$a1,1
	addi $v0,$v0,1
	beq $t2,$zero,chrf
	bne $t1,$t2,chro
	j chrfi
chrf:	add $v0,$zero,$zero
chrfi:	jr $ra
#funcion que devuelve el ult lugar del 1 carac de  primera cadena en la segunda
#recibe en a0 la 1 cadena en a1 la 2 cadena, a3 la longitud de cadena2 y devuelve v0 el numero	
rchr:
	add $a1,$a3,$a1
	addi $a1,$a1,-1
	
	add $v0,$zero,$zero
	lb $t1, 0($a0)
rchro:	lb $t2, 0($a1)
	addi $a1,$a1,-1
	addi $v0,$v0,1
	beq $t2,$zero,rchrf
	bne $t1,$t2,rchro
	sub $v0,$a3,$v0
	addi $v0,$v0,1
	j rchrfi
rchrf:	add $v0,$zero,$zero
rchrfi:	jr $ra
#función que invierte la cadena
#recibe en a0 la cadena a invertir
#en a1 la cadena destino
Invertir: 
	add $a0,$a0,$a2
revot:	lb $t0,0($a0)
	addi $a0,$a0,-1
	beq $t0,$zero,frev
	sb $t0,0($a1)
	addi $a1,$a1,1
	j revot
frev:	jr $ra
#funcion que busca la primera palabra en la segunda 
#recibe en a0 la primera cadena, en a1 la segunda
#devuelve en numero de caracteres desde que empieza hasta que ve y acaba la 1 palabra 
str:	add $v0,$zero,$zero
	
strnc:	add $t3,$a0,$zero
	lb $t1,0($t3)
	addi $t3,$t3,1
	add $t0,$zero,$zero
	
	lb $t2,0($a1)
	addi $a1,$a1,1
	addi $v0,$v0,1
	add $t5,$v0,$zero
	beq $t2,$zero,strf
	add $t4,$a1,$zero
	bne $t1,$t2, strnc
	
strsc:	addi $t0,$zero,1
	lb $t1,0($t3)
	addi $t3,$t3,1
	lb $t2,0($t4)
	beq $t1,$zero,strf
	bne $t1,$t2, strnc
	addi $t4,$t4,1
	addi $t5,$t5,1
	j strsc
	
strf:	add $v0,$t5,1
	bne $t0,$zero,strfin
	add $v0,$zero,$zero	

strfin:	jr $ra
#función que pasa de hexadecimal a decimal
#recibe en a0 la cadena en hex
#devuelve v0 con el numero en decimal o 0 sino existe
hexadec:
	addi $t0,$zero,64
	addi $t1,$zero,71
	addi $t4,$zero,48
	addi $t5,$zero,58
	add $t6,$zero,$zero
	
	lb $t7,0($a0)
	beq $t7,$t4,nohexa
	addi $t4,$t4,-1
	
Othex:	lb $t7,0($a0)
	beq $t7,$zero,nomohex
	slt $t8,$t0,$t7
	beq $t8,$zero,numhe
	slt $t8,$t7,$t1
	beq $t8,$zero,nohexa
	addi $t7,$t7,-55
	sb $t7,0($a0)
	addi $t6,$t6,1
	addi $a0,$a0,1
	j Othex
numhe:	slt $t8,$t4,$t7
	beq $t8,$zero,nohexa
	slt $t8,$t7,$t5
	beq $t8,$zero,nohexa
	addi $t7,$t7,-48
	sb $t7,0($a0)
	addi $t6,$t6,1
	addi $a0,$a0,1
	j Othex	
	
nomohex:addi $a0,$a0,-1
	lb $t0,0($a0)
	addi $a0,$a0,-1
	add $v0,$zero,$t0
	addi $t6,$t6,-1
	add $t1,$zero,$zero
	
mnumb:	addi $t1,$t1,1
	lb $t0,0($a0)
	addi $a0,$a0,-1
	add $t3,$t1,$zero
Ot16:	beq $t6,$zero,hexfin
	sll $t0,$t0,4
	addi $t3,$t3,-1
	bne $t3,$zero,Ot16
	add $v0,$v0,$t0
	addi $t6,$t6,-1
	bne $t6,$zero,mnumb
	
	j hexfin		
nohexa: add $v0,$zero,$zero	
hexfin:	jr $ra
#función que repite la cadena tanas veces como diga el numero
#recibe en a1 el numero,en a0 la cadena y en a2 el destino 
rep:
	add $t0,$zero,$zero
	
Otpal:	add $t1,$a0,$zero
	beq $a1,$t0,nmpal
	addi $t0,$t0,1
	
otlet:	lb $t2,0($t1)
	addi $t1,$t1,1
	beq $t2,$zero,Otpal
	sb $t2,0($a2)
	addi $a2,$a2,1
	j otlet
	
nmpal:	jr $ra
	
	