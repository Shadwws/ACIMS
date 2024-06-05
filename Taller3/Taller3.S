#define __SFR_OFFSET 0
#include "avr/io.h"


.global setup
.global loop

setup:
  SBI DDRD, 0
  SBI DDRD, 1 // Todos estos configuran la dirección de memoria del pin en modo salida (poniendo un 1)
  SBI DDRD, 2   
  SBI DDRD, 3
  SBI DDRD, 4
  SBI DDRD, 5

  CBI PORTD, 0
  CBI PORTD, 1
  CBI PORTD, 2
  CBI PORTD, 3 // Estos de aca inicializan el valor de la salida en 0 (es como hacer int a = 0)
  CBI PORTD, 4
  CBI PORTD, 5

ret // Es literalmente un return.

loop:

  SBI PORTD, 5 // Prendo el led rojo del segundo semáforo
  SBI PORTD, 0 // Prendo el led verde
  RCALL delay // espero 2000 ms
  CBI PORTD, 0 // Apago el led verde

  LDI r16, 0 // Establezco el contador
  LDI r17, 8 // Establezco la cantidad de parpadeos
  RCALL Ptitileo // Titileo la primera luz amarilla la cantidad de veces establecida


  SBI PORTD, 2 // Prendo el led rojo
  CBI PORTD, 5 // Apago el rojo del segundo semaforo
  SBI PORTD, 3 // Prendo el led verde del segundo semáforo
  RCALL delay  // espero 2000 ms
  CBI PORTD, 3 // Apago el led verde del segundo semáforo

  LDI r16, 0 // Reinicio el contador
  RCALL Stitileo // Titileo la luz amarilla del segundo semáforo
  CBI PORTD, 2 // Apago el led rojo del primer semáforo


  rjmp loop //Se reinicia el bucle




delay:

    ldi  r18, 163 // Cargo la cantidad de iteraciones del primer bucle.
    ldi  r19, 87 // Cargo la cantidad de iteraciones del segundo bucle.
    ldi  r20, 1 // Cargo la cantidad de iteraciones del tercer bucle.

    // Los ciclos totales de el bucle anidado deberían estar alrededor de los 31,999,993 así se tardaría 2 segundos en terminar
    // Considerando que se utiliza una frecuencia de reloj de 16 Mhz.

  L1: 

    dec  r20 // Decremento r20
    brne L1 // Si no es igual a 0 repito.
    dec  r19 // si r20 ya es iguial a cero hago lo mismo con r19
    brne L1
    dec  r18 // Cuando r19 es igual a cero hago lo mismo con r18
    brne L1
    nop // cuando r18 es igual a cero, ejecuto esta instrucción que no hace nada, pero ocupa un ciclo de clock igual
    ret


Ptitileo:

  cp r16, r17 // Comparo el índice con el límite del bucle
  BREQ retorno // Si ya se ejecutó 8 veces regreso al loop original.

  SBI PORTD, 1 // prendo el led amarillo del primer semáforo.
  RCALL titileo // Espero 250 ms.
  CBI PORTD, 1 // Apago el led amarillo
  RCALL titileo // Vuelvo a esperar 250 ms.
  INC r16 // Incremento el contador del bucle.
  jmp Ptitileo // repito.


Stitileo:

  cp r16, r17 // Comparo el índice con el límite del bucle
  BREQ retorno // Si ya se ejecutó 8 veces regreso al loop original.

  SBI PORTD, 4 // prendo el led amarillo del segundo semáforo.
  RCALL titileo // Espero 250 ms.
  CBI PORTD, 4 // Apago el led amarillo
  RCALL titileo // Vuelvo a esperar 250 ms.
  INC r16 // Incremento el contador del bucle.
  jmp Stitileo // repito.



// Esta función es igual a la del dilay pero configurada para durar 250 ms.

titileo:

    ldi  r21, 21
    ldi  r22, 75
    ldi  r23, 189

  L2: 

    dec  r23
    brne L2
    dec  r22
    brne L2
    dec  r21
    brne L2
    nop
    ret


// Retorna al bucle original.

retorno:
  ret








