int filas = 22;
int filas_pre = 22;
int columnas = 10;
int columnas_pre = 10;

int[][] tableau = new int[filas][columnas];  
int[][] previsualizacion = new int[filas][columnas];  
int[][][] colores = new int[filas][columnas][3];  
int[][] L= {{-1, 0}, {0, 0}, {0, 1}, {1, 1}};
//int[][] L= {{0, 0}, {0, -1}, {-1, 0}, {0, 1}};

ArrayList<Monomino> celdas = new ArrayList<Monomino>();
ArrayList<Monomino> buffer = new ArrayList<Monomino>();
int total_celdas=celdas.size(); 
int fila_inicial, columna_inicial;


void setup() {  
  size(820, 820);

  buffer.add(new Monomino(4, 4, 255, 255, 255));
  buffer.add(new Monomino(5, 0, 0, 0, 255));

  buffer.add(new Monomino(8, 0, 0, 0, 255));
  agregarPolyomino(8, 5, 4, 0, buffer);
}

void draw() {

  traducirTablero(celdas, tableau, colores);
  dibujarTablero(410, 10, tableau, colores, 800, 2);

  text("Buffer: " + buffer.size(), 600, 400);
  text("Celdas: " + celdas.size(), 700, 400);
}

void traducirTablero(ArrayList<Monomino> arrayL_inicio, int[][] array_final, int[][][] array_color) {
  int i, j;
  Monomino test = new Monomino(0, 0, 0, 0, 0); 
  limpiarTablero(tableau);
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
  update(buffer, celdas); //Paso todo de buffer a celdas
  update(celdas, buffer); //El nuevo buffer es el actual estado de celdas
  if (key == 's' || key == 'S') {
    moverPolyomino(1, 0, 4, celdas);
  } else if (key == 'w' || key == 'W') {
    moverPolyomino(1, 0, 4, celdas);
  } else if (key == 'd' || key == 'D') {
    moverPolyomino(0, 1, 4, celdas);
  } else if (key == 'a' || key == 'A') {
    moverPolyomino(0, -1, 4, celdas);
  } else if (key == 'q' || key == 'Q') {
    girarPolyomino(4, celdas);
  }
}





void update(ArrayList<Monomino> partida, ArrayList<Monomino> llegada ) { //Se busca que llegada se vuelva igual a partida
  Monomino operador = new Monomino(0, 0, 0, 0, 0); 
  //if(llegada.size()==0){}
  //Borramos todo de llegada
  int cantidad_inicial = llegada.size(); //Obtenemos el tamaño del array de llegada
  for (int i=0; i<=cantidad_inicial; i++) { 
    if (llegada.size()>0) {
      llegada.remove(0);
    } //Borramos todos los elementos del conjunto de llegada
  }
  for (int i=0; i<=partida.size()-1; i++) { //Agregamos todos los elementos de partida a llegada
    operador = partida.get(i);
    llegada.add(operador);
  }
}

void agregarPolyomino(int fila, int columna, int n, int tipo, ArrayList<Monomino> arrayL) {
  fila_inicial=fila;
  columna_inicial=columna;
  for (int i=0; i<n; i++) {
    switch(tipo) {
    case 0:
      arrayL.add(new Monomino(L[i][0]+fila, L[i][1]+columna, 255, 255, 255));
      break;
    }
  }
}

void moverPolyomino(int des_fila, int des_columna, int n, ArrayList<Monomino> arrayL ) {
  Monomino operador = new Monomino(0, 0, 0, 0, 0); //Creamos el operador
  int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
  for (int i = cantidadCeldas-1; i>cantidadCeldas-1-n; i--) { 
    operador = arrayL.get(i);
    operador.aumentarFila(des_fila);
    operador.aumentarColumna(des_columna);
  }
}

void reflejarPolyomino(int n, ArrayList<Monomino> arrayL ) {
  Monomino operador = new Monomino(0, 0, 0, 0, 0); //Creamos el operador
  int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
  for (int i = cantidadCeldas-1; i>cantidadCeldas-1-n; i--) { 
    operador = arrayL.get(i);
    operador.reflect();
  }
}

void girarPolyomino(int n, ArrayList<Monomino> arrayL ) {
  Monomino operador = new Monomino(0, 0, 0, 0, 0); //Creamos el operador
  int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
  for (int i = cantidadCeldas-1; i>cantidadCeldas-1-n; i--) { 
    operador = arrayL.get(i);
    operador.rotate();
  }
}

void interferencia(ArrayList<Monomino> arrayL){
  Monomino operador1 = new Monomino(0, 0, 0, 0, 0);
  Monomino operador2 = new Monomino(0, 0, 0, 0, 0);
  
  int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
  for (int i = cantidadCeldas-1; i>cantidadCeldas-1-n; i--) { 
    operador = arrayL.get(i);
    operador.rotate();
  }
  
}
