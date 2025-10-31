.data 
mensaje_error: .asciiz "Error:No hay solucion para estos valores" # mensaje de error para cuanod no hay solucion
mensaje_a: .asciiz "Introdusca el numero a\n" #msj para pedir a
mensaje_b: .asciiz "Introdusca el numero b\n" #msj para pedir b
mensaje_c: .asciiz "Introdusca el numero c\n" #msj para pedir c
salto_linea: .asciiz "\n"
cuatro: .double 4.0
dos: .double 2.0
uno_neg: .double -1.0
msj_positivo: .asciiz "El resultado con + es: \n"
msj_negativo: .asciiz "El resultado con - es: \n"

.text
.globl main

main: 
	la $a0 mensaje_a 
	li $v0 4 # pedimos el numero a con un mensaje
	syscall
	li $v0 7
	syscall #recibimos el numero a 
	mov.d $f2 $f0 #movemos el numero a $f2
	la $a0 mensaje_b 
	li $v0 4 # pedimos el numero b con un mensaje
	syscall
	li $v0 7
	syscall #recibimos el numero b 
	mov.d $f4 $f0 #movemos el numero recibido a $f4
	la $a0 mensaje_c
	li $v0 4 # pedimos el numero c con un mensaje
	syscall
	li $v0 7
	syscall #recibimos el numero c 
	mov.d $f6 $f0 #movemos el numero recibido a $f6
	l.d $f8 cuatro #cargamos el 4.0 en $f8
	l.d $f10 dos #cargamos el 2.0 en $f10
	#$f2=a, $f4=b, $f6=c, $f8=4.0, $f10 =2.0
	mul.d $f12 $f4 $f4 #calculamos $f12 = b²
	mul.d $f14 $f2 $f8#calculamos $f14=4*a
	mul.d $f16 $f14 $f6 #calculamos $f16= 4a*c
	sub.d $f18 $f12 $f16#calculamos $f18= b² -4ac 
	c.lt.d $f18 $f30 # flag 0 = true si se cumple la condicion
	bc1t Error #si la flag 0 = true hace salto a Error
Solucion:		
	#caso si hay solucion
	sqrt.d $f16 $f18 #f16 = raiz(b² -4ac)
	l.d $f20 uno_neg #cargamos $f20 = -1.0
	mul.d $f22 $f4 $f20 #$f12 = -b
	mul.d $f14 $f2 $f10 #$f14 = 2a
	#calculemos con +
	add.d $f18 $f22 $f16
	div.d $f12  $f18 $f14
	la $a0 msj_positivo
	li $v0 4
	syscall
	li $v0 3
	syscall #imprimimos el primer resultado 
	la $a0 salto_linea
	li $v0 4 #hacemos un salto de linea
	syscall
	#calculamos con -
	sub.d $f18 $f22 $f16 
	div.d $f12 $f18 $f14
	la $a0 msj_negativo
	li $v0 4
	syscall
	li $v0 3
	syscall
	j Salir
	
	
	
	
	
Error:
	la $a0 mensaje_error #imprimimos el error 
	li $v0 4 
	syscall
	j Salir 
	
Salir:
	li $v0 10 #cerramos el programa
	syscall
	
	
	
