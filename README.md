# Tetris programacion orientada a objetos
---
**Tabla de contenido**

- Objetivo
- Descripción
- Clases y métodos implementados
- Seleccion de estrategias
    + Tablero de juego
    + Puntuacion
- Estrategia de jugabilidad y puntaje
    + Nivel
    + Puntuación
- Instrucciones de juego
- Posibles mejoras
- Conclusiones

## Objetivo
La programación orientada a objetos nos permite implementar una nueva forma de estructurar soluciones a problemas dados. Para comprender sus limitaciones, ventajas y nuevas posibilidades se plantea rediseñar el proyecto anterior llevandolo al paradigma de programacion orientada a objetos. El principal objetivo de esta practica es familiarizarse con las nuevas herramientas de este paradigma, implementandolo en un problema ya solucionado con programacion estructurada, permitiendo realizar comparaciones razonables entre formas de abordar el mismo problema,sus dificultades de solucione y sus caracteristicas propias en cada una de las situaciones problema.
## Descripción
Como ejercicio de programación de la clase de POO anteriormente se planteó desarrollar el clasico ruso de los videojuegos [Tetris](https://es.wikipedia.org/wiki/Tetris), utilizando como paradigma de desarrollo la programacion estructurada. Para esta tarea se utilizó [Processing](https://processing.org), lenguaje de programacion y entorno de desarrollo integrado basado en Java. Como objetivo principal de este nuevo trabajo se plantea desarrollar el mismo videojuego utlizando programación orientada a objetos.Gracias a esta nueva condición se implamentan nuevas formas de abordar el problema, adicionalmente el profesor impone nuevas condiciones, donde delimita el desarrollo del proyecto con las siguientes directrices:

- Realizar algun tipo de innovación a la jugabilidad.
- Almacenar el tablero en un ```array``` de enteros de 2 dimensiones.
- Desarrollar la clase ```Poliomino``` (o ```Tetromino```).
- Contar con un metodo ```Reflect()``` y ```Rotate()```
- Contar con el metodo ```update()```

Bajo estas condicones y la informacion referente a jugabilidad y puntuacion (extraida del [articulo de Tetris en Wikipedia](https://en.wikipedia.org/wiki/Tetris)) se lleva a cabo el desarrollo de un Tetris Tematico, con metodos de juego adicionales y estrategias de jugabilidad variadas.

## Clases implementadas

### ```monomino```
Dado que la unidad atomica de tetris es el "Monominó", puede considerarse practico crear una clase para este ente. La clase ```Monominó``` cuenta con el siguiente constructor:

```Monomino (int fila, int columna, color c, int au_fila, int au_col)```

el parametro ```fila``` y ```columna``` almacenaran la información suficiente para definir su posicion, el paramentro ```c``` almacenará el color con el que se visualizará el monominó, los parametros ```au_fila``` y ```au_col``` almacenaran y definiran la informacion referente a desplazamientos, esto será de vital importancia cuando se explique la forma en que se realizar las rotaciones y reflexiones.

Posee los metodos ```reflect()``` y ```rotate()``` lo cuales se encargan de operaciones de transformación, adicionalmente contiene los metodos ```aumentarFila()``` y ```aumetarColumna()``` los cuales son responsables de desplazar el monominó atraves del tablero cambiado en valor de  ```pos_fila``` y ```pos_columna```.

```
void aumentarFila(int x) {     
    pos_fila+= x;
    aumento_fila+=x;
  } 
  void aumentarColumna(int x) { 
    pos_columna+=x;
    aumento_columna += x;
  } 
```

###  ```tablero```

El tablero es la entidad sobre la que reposan las celdas, sus metodos están orientados a dos objetivos; Representar graficamente y realizar operaciones propias de un tablero (Eliminar filas, tipos especiales de llenado, vaciado, etc). Este tablero tiene como espacio de memoria (donde existen los monominós) un ```ArrayList<Monomino>``` con todos los monominós que existen durante el juego, adicionalmente, como requisito del trabajo y como estrategia de representación cuenta con un "Array int[][]" donde guarda las posiciones de los monominós de forma 'tradicional'. Cuenta con el siguiente constructor:

```
Tablero(int pos_x, int pos_y, int fil_ocul, int alt, ArrayList<Monomino> tab, int[][] int_tab )
```

Los parametros del constructor ```pos_x``` y ```pos_y``` determinan la posicion de la pantalla donde podrá dibujarse el tablero, el parametro ```fil_ocul``` permite elegir si se desea que el tablero oculte las primeras 'n' filas, logrando asi insertar los poliominós en un lugar invisible para el jugador, la variable ```alt``` determina la altura con la que se mostrará el tablero.

Cuenta con los siguientes metodos:

- ```traducirTablero()``` Este metodo toma el ```ArrayList<Monomino>```, recorre cada objeto y almacena las coordenadas de posicion en el "Array int[][]".

- ```dibujarTablero(boolean border, boolean psycho, boolean randomGeo, int _geo)``` Este metodo toma el ```Array int[][]```, recorre cada objeto y lo grafica con diferentes estrategias de graficación condicoinadas por los booleanos que la componen. El entero ```_geo``` determina la estrategia de graficacion del modo randomGeo.

-```limpiarTablero()``` Vacia el tablero de enteros de la respresentación.

-```llenarBordes()``` Activa todos los bordes del tablero, añadiendo un monomino en cada posicion.

-```borrarInterno()``` ellimina todas las celdas del ```ArrayList<Monomino>``` que no pertenezcan a los bordes.

-```quitarFilas(int [] filas)``` elimina las filas correspondientes a cada valor de los elementos de [] filas.
-```identificarFilas()``` retornar un array de enteros con las filas llenas.

-```interferencia()``` retorna ```true``` si hay dos monomios con la misma posicion.




### ```polyomino```

El polyomino es una agrupación de varios monominós, esta idea se aplica para está clase, la clase ```polyomino``` contiene metodos que actuaran sobre los ultimos ```n``` monominos agregados al tablero, siendo ```n``` el entero que representa la cantidad de monominos que tiene el polyomino. Su constructor tiene los siguientes parametros:

``` Polyomino(Tablero tablero, int n) ```

El poliomino recibe como parametro el tablero donde estará, adicionalmente el valor ```n``` corresponder a la cantidad de monominos del que será compuesto.

Contiene los siguientes metodos:

-```agregarPolyomino(int fila, int columna, int tipo)``` agrega un polinomio de tipo ```tipo``` en la posicion ```fila``` y ```columna```.

-```moverPolyomino(int des_fila, int des_columna)``` mueve el polinomio  ```des_fila``` celdas en fila , y mueve el poliomino ```des_columna``` celdas en columna ```columna```, retorna ```true``` si encuentra que la nueva posicion representa una colision.

-```reflejarPolyomino()``` refleja el poliomino respecto al eje "y".

-```girarPolyomino()``` gira el poliomino en sentido horario.

-```obtenerCentro()``` retorna un array de enteros con las coordenadas en el tablero del centro del poliomino.




## Selección de estrategias
### Tablero de juego
El tablero de juego que se muestra es una **Array** de 2 dimensiones, el cual podemos representar como una matriz de filas y columnas que podemos elegir al empezar el juego.

### Puntuación 
Cada vez que el jugador desplaze la figura hacia abajo antes de que el juego lo haga automaticamente sumará 1 punto a su puntaje, adicionalmente a esto el metodo  ```  identificarFilas() ```  permitirá sumar un puntaje especifico al jugador de acuerdo a cuantas filas elimine en combo. 

## Estrategias de jugabilidad y puntuación
La jugabilidad y puntuación se ha hecho basado en las versiones comerciales del Tetris, imitando lo más posible sus dinamicas. El tiempo de bajada de los tetrominós se va reduciendo cada vez que uno de los tetrominós detecta una colision bajo el. Adicionalmente cuenta con la opción "comodin", la cual le permitirá realizar la operacion de reflejo del polyomino o la operacion de subir el poliomino. Cada vez que se use un comodin se gasta, cada vez que se completa una fila se adicion un comodin al jugador.

### Nivel
El nivel se determina de acuerdo a las filas que ha completado, cada vez que se completan 10 filas aumenta un nivel.
### Puntuación
La puntuacion aumenta en dos situaciones:

Cuando el jugador desplaza el tetromino antes de que el tiempo de bajada se cumpla, esta acción sumará 1 punto por cada celda que el jugador baje. 

Cada vez que complete una o más filas. El puntaje que se adiciona depende de la cantidad de filas que haga en combo, como la dificultad del combo crece exponencialmente, asi mismo lo hará el puntaje, de acuerdo a la siguiente linea de codigo:
```processing
puntaje += 100 * pow(2, filas_quitadas-1);}
```

## Instrucciones de juego

Cada una de las pantallas del juego está pensada para hacer explicitas las acciones del jugador, o almenos, darle la informacion suficiente para la proxima pantalla de juego.


## Posibles mejoras

- Optimizar el proceso de analisis de colisiones, debido a que revisa cada una de los monominos puede representar una carga excesiva para el tiempo de ejecucion.
- La parte grafica puede mejorarse, las opciones de geometria random pueden expandirse mucho más.
- Se pueden agregar los poliominos que se deseen, ya que el algoritmo es generalizable para poliominos de grado n.

## Conclusiones

- El paradigma de programacion orientada a objetos logró reducir la cantidad de lineas de codigo del programa.
- El paradigma de programacion orientada a objetos facilito  la generalizacion del algoritmo de deteccion de colisiones.
- Se logró optimizar la forma en que los poliominos se ingresan al videojuego.
- El paradigma de programacion orientada a objetos permite tener mucho más control sobre las caracteristicas de cada elemento del tetris.









