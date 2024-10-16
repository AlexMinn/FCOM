	
	#imprime en pantalla lo que tiene s0
	add $a0,$s0,$zero 
	li $v0, 1
	syscall
	
	#imprimir caracteres sueltos
	add $a0,$zero, 32 #pone aqui en ascci el caracter 
	li $v0, 11
	syscall
	
	#imprime cadena
	la $a0, H	#posicio de la cadena
	li $v0, 4
	syscall
	
	#coge de tleclado un numero
	li $v0,5
	syscall #devuelve el entero
	
	#coge cadena de teclado
	li $v0,8
	li $a1,15
	la $a0, cadena #lee 15 datos o hasta que se de intro y guarda en cadena
	syscall 
	
	
	#se llama la funcion con jal X
	#
	#X:
	#retorno con jr $ra 