.data 
masa_Tierra: .double 5.97e24
masa_Luna: .double 7.3e22
distancia: .double 384000
gravedad: .double 6674e-11
.text
.globl main

main:
	l.d $f0 masa_Tierra
	l.d $f2 masa_Luna
	l.d $f4 distancia
	l.d $f6 gravedad
	mul.d $f8 $f0 $f2 #multiplicamos la masa de la tierra por la masa de la luna
	mul.d $f0 $f4 $f4 #calculamos el cuadrado de la distancia entre ambos cuerpos
	div.d $f4 $f8 $f0 #calculamos la division del producto de las masas entre el cuadradi de la distancia de los cuerpos
	mul.d $f12 $f4 $f6 #multiplicamos el gravedad por ((masa1*masa2)/distancia al cuadrado)
	li $v0 3 #cargamos para imprimir un double
	syscall
	li $v0 10 #cerramos el programa
	syscall
	
