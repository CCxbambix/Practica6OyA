.data
	num1: .asciiz "Introduce el primer numero a operar:"
	num2: .asciiz "\nIntroduce el segundo numero por el cual vamos a multiplicar al primero:"
	resultado: .asciiz "\nEl resultado es: "
	nan: .asciiz "Error, el resultado no es un numero."
	inf: .asciiz "Error, el resultado es infinito"
.text
.globl main
main:
	#primer numero
	la $a0, num1 #pide el primer numero
	li $v0, 4 #imprime el mensaje
    	syscall
    	li $v0, 7 #lee double y lo guarda en f0
    	syscall
    	mov.d $f4, $f0 #mueve el primer numero a f4

	#segundo numero
	la $a0, num2 #pide el segundo numero
	li $v0, 4 #imprime el mensaje
    	syscall
    	li $v0, 7 #lee double y lo guarda en f0
    	syscall
    	mov.d $f6, $f0 #mueve el primer numero a f6
    	
	#operacion
	mul.d $f0, $f4, $f6 #f0 = f4*f6
	
	mfc1 $t0, $f1 #parte alta del resultado en f1
	mfc1 $t1, $f0 #parte baja del resultado en f0    
	
    	#verificamos si es NaN o Infinito comparando el exponente con 0x7FF
    	li $t2, 0x7FF00000 #guardamos el exponente en t2
    	and $t3, $t0, $t2 #obtenemos solo el exponente
    	bne $t3, $t2, normal #si no es 0x7FF, es número normal
    
    	#verificamos si es NaN
    	li $t4, 0x000FFFFF #guardamos la mantisa alta
	and $t5, $t0, $t4 #parte alta de la mantisa
    	or $t5, $t5, $t1 #combina mantisa alta con mantisa baja en f5
    	bnez $t5, es_nan #si f5 no es 0, es NaN
    	j infinito #si f5 es 0 entonces es infinito y salta a dicho caso

normal:
    	la $a0, resultado #guarda el mensaje del resultado en a0
    	li $v0, 4 #imrpime el mensaje
    	syscall
    	mov.d $f12, $f0 #mueve el resultado a f12 para imprimir
    	li $v0, 3 #imprime el resultado
    	syscall
    	j fin

es_nan:
    	la $a0, nan #guarda el mensaje de nan en a0
    	li $v0, 4 #imrpime el mensaje
    	syscall
    	j fin

infinito:
    	la $a0, inf #guarda el mensaje de ninfinito en a0
    	li $v0, 4 #imrpime el mensaje
    	syscall

fin:
    	#finalizar programa
    	li $v0, 10
    	syscall