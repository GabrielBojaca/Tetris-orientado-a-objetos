class Tablero {
  int _x;
  int _y;
  int _alto;
  int _ancho;
  int _filas_ocultas=4;
  int _filas;
  int _columnas;

  color [][] colores = new color[filas][columnas]; 
  ArrayList<Monomino> arrayL = new ArrayList<Monomino>(); 
  int[][] tablero_enteros = new int[_filas][_columnas];
  //      Posicion X Posicion Y   Filas Ocultas Altura  ArrayList de referencia   int array tablero
  Tablero(int pos_x, int pos_y, int fil_ocul, int alt, ArrayList<Monomino> tab, int[][] int_tab ) {
    _x = pos_x;
    _y = pos_y;
    arrayL = tab;
    _filas_ocultas = fil_ocul;
    _alto=alt;
    tablero_enteros = int_tab;    
    _filas = int_tab.length;    
    _columnas = int_tab[0].length;
  }


  void traducirTablero() {
    // println("Se ha traducido");
    int i, j; //Inicializa i j
    Monomino test = new Monomino(0, 0, 0, 0, 0); //Instancia operador
    limpiarTablero(); //Limpia tablero de enteros
    for (int k = 0; k<=arrayL.size()-1; k++) { //Recorre el ArrayList
      test = arrayL.get(k);  //apunta a K
      i = test.getFila();    //Obtiene su fila
      j = test.getColumna(); //Obtiene su columna
      tablero_enteros[i][j]=1; //Setea unos
      colores[i][j]= test.getColor();
    }
  }
  //void dibujarTablero(int pos_x, int pos_y, int[][] tablero, color [][]array_color, int alto, int filas_ocultas)
  void dibujarTablero(boolean border, boolean psycho, boolean randomGeo, int _geo) {
    // int filas_ocultas = 2;
    float _ancho=(float(_columnas)/float(_filas-_filas_ocultas))*_alto;
    fill(100);
    rect(_x-_ancho/_columnas, _y-(_alto/(_filas-_filas_ocultas)), _ancho+_ancho/_columnas, _alto+(_alto/(_filas-_filas_ocultas)));
    push();
    for (int i=0; i<=tablero_enteros.length-1; i++) { //Filas
      for (int j=0; j<=tablero_enteros[0].length-1; j++) { //Columna


        if (tablero_enteros[i][j]==1) {
          fill(colores[i][j]); 
          stroke(0, 0, 0);
        } else {
          fill(0, 0, 0); 
          stroke(255);
        }



        if (i>=_filas_ocultas-1) {
          println(i);
          if (!border) {
            noStroke();
          }
          if (psycho) {
            rect((j*(_ancho/_columnas))+_x, (((i-_filas_ocultas)*_alto)/(_filas-_filas_ocultas))+_y, _ancho/_columnas, _alto/(_filas-_filas_ocultas), random(0, 40));
          }
          if (randomGeo) {
            // println(_geo);
            if (_geo == 0) {             
              beginShape();
              vertex(((j*_ancho/_columnas)+_x) + 1 * (_ancho/_columnas), (((i-_filas_ocultas)*_alto/(_filas-_filas_ocultas))+_y) + 0 * (_ancho/_columnas));
              vertex(((j*_ancho/_columnas)+_x)-0.5 * (_ancho/_columnas), (((i-_filas_ocultas)*_alto/(_filas-_filas_ocultas))+_y) + 0.86602 * (_ancho/_columnas));
              vertex(((j*_ancho/_columnas)+_x)-0.49 * (_ancho/_columnas), (((i-_filas_ocultas)*_alto/(_filas-_filas_ocultas))+_y) - 0.86602 * (_ancho/_columnas));
              endShape(CLOSE);
            } else if (_geo ==1) {
              polygon((j*_ancho/_columnas)+_x, ((i-_filas_ocultas)*_alto/(_filas-_filas_ocultas))+_y, (_ancho/_columnas)/2, 6);
            } else if (_geo ==2) {
              rect((j*_ancho/_columnas)+_x, ((i-_filas_ocultas)*_alto/(_filas-_filas_ocultas))+_y, _ancho/_columnas, _alto/(_filas-_filas_ocultas));
            } else if (_geo ==3) {
              ellipse((j*_ancho/_columnas)+_x, ((i-_filas_ocultas)*_alto/(_filas-_filas_ocultas))+_y, (_ancho/_columnas), _alto/(_filas-_filas_ocultas));
            }
            else if(_geo ==4){
              polygon((j*_ancho/_columnas)+_x, ((i-_filas_ocultas)*_alto/(_filas-_filas_ocultas))+_y, (_ancho/_columnas), 6);
            }
          }


          if (psycho == false && randomGeo == false) {
            rect((j*_ancho/_columnas)+_x, ((i-_filas_ocultas)*_alto/(_filas-_filas_ocultas))+_y, _ancho/_columnas, _alto/(_filas-_filas_ocultas));
          }
        }



        // rect((j*_ancho/_columnas)+_x, ((i-_filas_ocultas)*_alto/(_filas-_filas_ocultas))+_y, _ancho/_columnas, _alto/(_filas-_filas_ocultas),millis()%40);
        //  println("dibujado " +  ((j*_ancho/columnas)+_x)+ " "  + ((i-_filas_ocultas)*_alto/(_filas-_filas_ocultas))+_y );
      }
    }
    pop();
  }

  //  void limpiarTablero(int[][] clean) {
  void limpiarTablero() {
    push();
    for (int i=0; i<=tablero_enteros.length-1; i++) { //Filas
      for (int j=0; j<=tablero_enteros[0].length-1; j++) { //Columna    
        tablero_enteros[i][j]=0;
      }
    }
    pop();
  }  

  void llenarBordes() {
    for (int i=0; i<=_filas-1; i++) {
      arrayL.add(new Monomino(i, 0, color(230), 0, 0));
    }
    for (int i=0; i<=_filas-1; i++) {
      arrayL.add(new Monomino(i, _columnas-1, color(230), 0, 0));
    }

    for (int i=1; i<=_columnas-2; i++) {
      arrayL.add(new Monomino(0, i, color(230), 0, 0));
    }

    for (int i=1; i<=_columnas-2; i++) {
      arrayL.add(new Monomino(_filas-1, i, color(230), 0, 0));
    }
  }

  void borrarInterno() {


    int i, j;
    Monomino test = new Monomino(0, 0, 0, 0, 0); //Instancia operador
    limpiarTablero(); //Limpia tablero de enteros
    int cantidadCeldas= arrayL.size();
    for (int k = cantidadCeldas-1; k>=0; k--) { //Recorre el ArrayList
      test = arrayL.get(k);  //apunta a K
      i = test.getFila();    //Obtiene su fila
      j = test.getColumna();    //Obtiene su fila
      if ( (i!=0) && (j!=0) && (i!=_filas-1) && (j!=_columnas-1)) {
        arrayL.remove(k);
      }
    }
  }



  void quitarFilas(int []retirar) {

    int i;
    //   println(retirar);
    Monomino test = new Monomino(0, 0, 0, 0, 0); //Instancia operador
    limpiarTablero(); //Limpia tablero de enteros
    for (int n=0; n<=retirar.length-1; n++) {
      int cantidadCeldas= arrayL.size();
      for (int k = cantidadCeldas-1; k>=0; k--) { //Recorre el ArrayList
        test = arrayL.get(k);  //apunta a K
        i = test.getFila();    //Obtiene su fila
        if (i==retirar[n]) {
          arrayL.remove(k);
        }
      }
      bajarFilasSuperiores(retirar[n]);
    }
  }

  void bajarFilasSuperiores(int filaAReemplazar) {
    Monomino operador = new Monomino(0, 0, 0, 0, 0); //Instancia operador
    int cantidadCeldas= arrayL.size();
    for (int f=cantidadCeldas-1; f>=0; f--) {
      operador = arrayL.get(f);
      if (operador.getFila()<filaAReemplazar) {
        operador.aumentarFila(1);
      }
    }
  }

  int[] identificarFilas() {
    int [] cantidadCeldasFila= new int[_filas];
    int [] filasLlenas = {};
    Monomino test = new Monomino(0, 0, 0, 0, 0); //Instancia operador
    limpiarTablero(); //Limpia tablero de enteros
    int cantidadCeldas= arrayL.size();
    for (int k = cantidadCeldas-1; k>=0; k--) { //Recorre el ArrayList
      test = arrayL.get(k);  //apunta a K
      cantidadCeldasFila[test.getFila()]+=1;
    }

    for (int n = 0; n<=_filas-1; n++) {
      if (cantidadCeldasFila[n]==_columnas) {
        filasLlenas = append(filasLlenas, n);
      }
    }
    return filasLlenas;
  }


  boolean interferencia() {
    Monomino operador1 = new Monomino(0, 0, 0, 0, 0);
    Monomino operador2 = new Monomino(0, 0, 0, 0, 0);

    int cantidadCel = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
    for (int i = 0; i<=cantidadCel-1; i++) { 
      operador1 = arrayL.get(i);
      for (int j = 0; j<=cantidadCel-1; j++) {
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
      if (operador1.getFC()[0] < 0 || operador1.getFC()[0] > _filas-1  || operador1.getFC()[1] < 0 || operador1.getFC()[1] > _columnas-1 ) {
        return true;
      }
    }
    return false;
  }

  ArrayList<Monomino> retornar() {    
    return arrayL;
  }

  void polygon(float x, float y, float radius, int npoints) { //Extraido de https://processing.org/examples/regularpolygon.html
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}
