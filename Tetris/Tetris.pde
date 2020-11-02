int filas = 22;
int filas_pre = 22;
int columnas = 11;
int columnas_pre = 10;

int[][] tableau = new int[filas][columnas];  
int[][] previsualizacion = new int[filas][columnas];  
int[][][] colores = new int[filas][columnas][3]; 
int[][] L= {{0, 0}, {0, -1},  {1, 0}, {1, 1}};
//int[][] L= {{-1, 0}, {0, 0}, {0, 1}, {1, 1}};
//int[][] L= {{0, 0}, {0, -1}, {-1, 0}, {0, 1}};

ArrayList<Monomino> celdas = new ArrayList<Monomino>();
ArrayList<Monomino> buffer = new ArrayList<Monomino>();
int total_celdas=celdas.size(); 
int fila_inicial, columna_inicial;
int orden_juego= 0;
int fila_origen= 0;
int columna_origen = 5;


boolean choque_inferior = false;

void setup() {  
  size(1000, 820);

  buffer.add(new Monomino(10, 4, 255, 255, 255, 0, 0));
  buffer.add(new Monomino(11, 4, 255, 255, 255, 0, 0));
  buffer.add(new Monomino(12, 4, 255, 255, 255, 0, 0));
  buffer.add(new Monomino(5, 0, 0, 0, 255, 0, 0));

  celdas.add(new Monomino(5, 10, 0, 0, 255, 0, 0));

  orden_juego = 4;

  if(orden_juego == 4){
   fila_origen = 0;
   columna_origen = 5;
  }


  buffer.add(new Monomino(8, 0, 0, 0, 255, 0, 0));
  buffer.add(new Monomino(9, 0, 0, 0, 255, 0, 0));
  agregarPolyomino(fila_origen, columna_origen, orden_juego, 0, buffer);
  update(buffer, celdas);
}

void draw() {
 if(choque_inferior ==true){
   agregarPolyomino(fila_origen, columna_origen, orden_juego, 0, buffer);
   choque_inferior = false;
 }
  traducirTablero(celdas, tableau, colores);
  dibujarTablero(500, 10, tableau, colores, 800, 2);

  traducirTablero(buffer, previsualizacion, colores);

  dibujarTablero(10, 10, previsualizacion, colores, 800, 2);



  text("Buffer: " + buffer.size(), 600, 400);
  text("Celdas: " + celdas.size(), 700, 400);
  // update(buffer, celdas); //Paso todo de buffer a celdas
  // update(celdas, buffer); //El nuevo buffer es el actual estado de celdas
}

void traducirTablero(ArrayList<Monomino> arrayL_inicio, int[][] array_final, int[][][] array_color) {
  int i, j;
  Monomino test = new Monomino(0, 0, 0, 0, 0, 0, 0); 
  limpiarTablero(array_final);
  for (int k = 0; k<=arrayL_inicio.size()-1; k++) {
    test = arrayL_inicio.get(k);
    i = test.getFila();
    j = test.getColumna();
    array_final[i][j]=1;
    array_color[i][j]= test.getRGB();
  }
}

void dibujarTablero(int pos_x, int pos_y, int[][] tablero, int[][][]array_color, int alto, int filas_ocultas) {
  // int filas_ocultas = 2; 
  float ancho=(float(columnas)/float(filas-filas_ocultas))*alto;
  push();
  for (int i=0; i<=tablero.length-1; i++) { //Filas
    for (int j=0; j<=tablero[0].length-1; j++) { //Columna
      if (tablero[i][j]==1) {
        fill(array_color[i][j][0], array_color[i][j][1], array_color[i][j][2]); 
        stroke(0, 0, 0);
      } else {
        fill(0, 0, 0); 
        stroke(255);
      }
      if (i>filas_ocultas-1) {
        rect((j*ancho/columnas)+pos_x, ((i-filas_ocultas)*alto/(filas-filas_ocultas))+pos_y, ancho/columnas, alto/(filas-filas_ocultas));
      }
    }
  }
  pop();
}

void limpiarTablero(int[][] clean) {
  push();
  for (int i=0; i<=clean.length-1; i++) { //Filas
    for (int j=0; j<=clean[0].length-1; j++) { //Columna    
      clean[i][j]=0;
    }
  }
  pop();
}

void keyPressed() {
  //result = test ? expression1 : expression2
  // s = (i < 50) ? 0 : 255;


  if (key == 's' || key == 'S') {
    if (moverPolyomino(1, 0, orden_juego, buffer)) { //Hay interferencia?
      update(celdas, buffer); //Buffer se vuelve celdas
      choque_inferior=true;
    } else {
      update(buffer, celdas); //Celdas e vuelve buffer
    }
  } else if (key == 'w' || key == 'W') {
    if (moverPolyomino(-1, 0, orden_juego, buffer)) { //Hay interferencia?
      update(celdas, buffer); //Buffer se vuelve celdas
    } else {
      update(buffer, celdas); //Celdas e vuelve buffer
    }
  } else if (key == 'd' || key == 'D') {
    if (moverPolyomino(0, 1, orden_juego, buffer)) { //Hay interferencia?
      update(celdas, buffer); //Buffer se vuelve celdas
    } else {
      update(buffer, celdas); //Celdas e vuelve buffer
    }
  } else if (key == 'a' || key == 'A') {

    if (moverPolyomino(0, -1, orden_juego, buffer)) { //Hay interferencia?
      update(celdas, buffer); //Buffer se vuelve celdas
    } else {
      update(buffer, celdas); //Celdas e vuelve buffer
    }
  } else if (key == 'q' || key == 'Q') {
    if (girarPolyomino(orden_juego, buffer)) { //Hay interferencia?
      update(celdas, buffer); //Buffer se vuelve celdas
    } else {
      update(buffer, celdas); //Celdas e vuelve buffer
    }
  }
obtener_centro(buffer,4);

}





void update(ArrayList<Monomino> partida, ArrayList<Monomino> llegada ) { //Se busca que llegada se vuelva igual a partida
  Monomino operador = new Monomino(0, 0, 0, 0, 0, 0, 0); 
  //Borramos todo de llegada
  int cantidad_inicial = llegada.size(); //Obtenemos el tamaño del array de llegada
  for (int i=0; i<=cantidad_inicial; i++) { 
    if (llegada.size()>0) {
      llegada.remove(0);
    } //Borramos todos los elementos del conjunto de llegada
  }
  for (int i=0; i<=partida.size()-1; i++) { //Agregamos todos los elementos de partida a llegada
    operador = partida.get(i);
    llegada.add(new Monomino(operador.getFila(), operador.getColumna(), operador.getR(), operador.getG(), operador.getB(), operador.getAu_F(), operador.getAu_C()));
  }
}

void agregarPolyomino(int fila, int columna, int n, int tipo, ArrayList<Monomino> arrayL) {
  fila_inicial=fila;
  columna_inicial=columna;
  for (int i=0; i<n; i++) {
    switch(tipo) {
    case 0:
      arrayL.add(new Monomino(L[i][0]+fila, L[i][1]+columna, 255, 0, 0, 0, 0));
      break;
    }
  }
}

boolean moverPolyomino(int des_fila, int des_columna, int n, ArrayList<Monomino> arrayL ) {
  Monomino operador = new Monomino(0, 0, 0, 0, 0, 0, 0); //Creamos el operador
  int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
  for (int i = cantidadCeldas-1; i>cantidadCeldas-1-n; i--) { 
    operador = arrayL.get(i);
    operador.aumentarFila(des_fila);
    operador.aumentarColumna(des_columna);
  }

  if (interferencia(arrayL, filas, columnas)) {
    return true;
  }

  return false;
}

void reflejarPolyomino(int n, ArrayList<Monomino> arrayL ) {
  Monomino operador = new Monomino(0, 0, 0, 0, 0, 0, 0); //Creamos el operador
  int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
  for (int i = cantidadCeldas-1; i>cantidadCeldas-1-n; i--) { 
    operador = arrayL.get(i);
    operador.reflect();
  }
}

boolean girarPolyomino(int n, ArrayList<Monomino> arrayL ) {
  Monomino operador = new Monomino(0, 0, 0, 0, 0, 0, 0); //Creamos el operador
  int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
  for (int i = cantidadCeldas-1; i>cantidadCeldas-1-n; i--) { 
    operador = arrayL.get(i);
    operador.rotate();
  }

  if (interferencia(arrayL, filas, columnas)) {
    return true;
  } else {
    return false;
  }
}

boolean interferencia(ArrayList<Monomino> arrayL, int l_fila, int l_columna) {
  Monomino operador1 = new Monomino(0, 0, 0, 0, 0, 0, 0);
  Monomino operador2 = new Monomino(0, 0, 0, 0, 0, 0, 0);

  int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
  for (int i = 0; i<=cantidadCeldas-1; i++) { 
    operador1 = arrayL.get(i);
    for (int j = 0; j<=cantidadCeldas-1; j++) {
      if (j!=i) {
        operador2 = arrayL.get(j);
        if (operador1.getFC()[0] == operador2.getFC()[0] && operador1.getFC()[1] == operador2.getFC()[1]) {
          // println("Chale" + millis());
          //println("operador 1 x " + operador1.getFC()[0] + " operador 2 y " + operador2.getFC()[1] );
          return true;
        }
      }
    }
    //*****************Colision superior o inferior*************//   //*************************Colision Lateral******************//
    if (operador1.getFC()[0] < 0 || operador1.getFC()[0] > l_fila-1  || operador1.getFC()[1] < 0 || operador1.getFC()[1] > l_columna-1 ) {
      return true;
    }
  }
  return false;
}

void obtener_centro(ArrayList<Monomino> arrayL,int n){
  int centrof,centroc;
  Monomino operador = new Monomino(0, 0, 0, 0, 0, 0, 0);
  int cantidadCeldas = arrayL.size(); 
  operador = arrayL.get(cantidadCeldas-n);
  centrof = operador.getFila();
  centroc = operador.getColumna();
  println("fila: " + centrof + " columna: " + centroc);
}
