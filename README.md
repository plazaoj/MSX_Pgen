# Generación Procedimental

Programas para crear laberintos por Generación Procedimental usando el generador de números pseudoaleatorios del MSX

## PGEN2.BAS

      LOAD"PGEN2.BAS",R
      
Pinta en pantalla un laberinto

Variando los valores de `SD` (línea 70) se obtienen distintos laberintos.

## PGEN5.BAS

     LOAD"PGEN5.BAS",R

Vista del laberinto por casillas, siempre que se use el mismo valor de `SD` (línea 110). El `sprite` de un coche sirve para recorrer el laberinto. Los cursores cambian la dirección, y se mueve permanentemente.

Al chochar con las paredes generalmente cambia de sentido, pero puede atravesar las paredes por efecto túnel si se insiste lo suficiente. Así se pueden visitar zonas originalmente desconectadas del laberinto.

## LAB.ASM

     asmsx lab.bin

Rutina en código máquina para pintar las paredes del laberinto. 

Compilar con asmsx. El fichero `lab.bin` creado es cargado por `PGEN5.BAS`.

Dirección de inicio y ejecución: `&HC000`

## Disclaimer

Este código ni se mantiene ni se actualiza. Simplemente se comparte para quien pueda interesar. Úsalo por tu cuenta y riesgo.