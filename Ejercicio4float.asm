.data 
masa_Tierra: .float 5.97e24
masa_Luna: .float 7.3e22
distancia: .float 384000
gravedad: .float 6674e-11
.text
.globl main

main:
	l.s $f0 masa_Tierra
	l.s $f1 masa_Luna
	l.s $f2 distancia
	l.s $f3 gravedad
	mul.s $f4 $f0 $f1 #multiplicamos la masa de la tierra por la masa de la luna
	mul.s $f0 $f2 $f2 #calculamos el cuadrado de la distancia entre ambos cuerpos
	div.s $f6 $f4 $f0 #calculamos la division del producto de las masas entre el cuadradi de la distancia de los cuerpos
	mul.s $f12 $f3 $f6 #multiplicamos el gravedad por ((masa1*masa2)/distancia al cuadrado)
	li $v0 2 #cargamos para imprimir un double
	syscall
	li $v0 10 #cerramos el programa
	syscall
	