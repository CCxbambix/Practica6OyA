.data
	m: .asciiz "Ingresa el numero de veces que quieras repetir la serie de Leibniz:"
	resultado: .asciiz "\nEl resultado de la serie es: "
	solucion: .float 0.0 
	uno: .float 1.0
	dos: .float 2.0
	cuatro: .float 4.0
.text
.globl main

main:
	#mensaje inicial
	la $a0, m #guarda en a0 el mensaje de pedir el valor de m
	li $v0, 4 #imprime el mensaje
    	syscall
	li $v0, 5 #obtener el valor de m
	syscall
	move $s0, $v0 #guarda el valor de m en s0
	
	#mensaje final
	la $a0, resultado #guarda en a0 el mensaje de dar el resultado
	li $v0, 4 #imprime el mensaje
    	syscall
    	
    	#variables y constantes a usar en el programa
    	li $t0, 0 #inicializamos el contador del loop en i = 0
    	l.s $f0, solucion #resultado que iremos acumulando inicializado en 0.0
    	l.s $f4, uno #constante 1.0 
    	l.s $f5, dos #constante 2.0 
    	l.s $f6, cuatro #constante 4.0
    	li $s1, 1 #constante para comparar el modulo 2 de i

leibniz: #loop general para obtener terminos de la serie
	bgt $t0, $s0, fin #loop donde compara i con m
	mtc1 $t0, $f9 #movemos t0 al coprocesador 1
    	cvt.s.w $f9, $f9 #convertimos el valor i de entero a flotante
    	
    	#denominador
	mul.s $f7, $f9, $f5 #guarda en f7, i*2
	add.s $f7, $f7, $f4 #suma 1+f7 y lo guarda en f7
	
	#termino
	div.s $f10, $f4, $f7 #dividimos 1 entre f7 y guardamos en f10 el termino 
	
	#determinamos si se suma o resta el termino
	andi $t2, $t0, 1 #obtenemos el modulo 2 de i
	beq $t2, $s1, impar #Compara i mod2 con 1, si i mod2= 0 se suma y sigue la ejecucion, si mod2=1 es impar y se resta el termino
	add.s $f0, $f0, $f10 #f0+=término
	j incremento #saltamos al incremento
impar:
	sub.s $f0, $f0, $f10 #f0-=término
incremento:
	addi $t0, $t0, 1 #aumenta i en uno 
	j leibniz
fin:
	mul.s $f0, $f0, $f6 #multiplicamos el resultado por 4
	mov.s $f12, $f0 #movemos el resultado a f12 para poder imprimirlo
	li $v0, 2 #imprimimos el resultado
	syscall
	
	#fin del programa
	li $v0, 10 #terminamos el programa
	syscall
	