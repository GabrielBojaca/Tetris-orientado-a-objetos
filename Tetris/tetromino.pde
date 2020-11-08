class Polyomino {

  int[][] P41= {{0, 0}, {0, -1}, {1, -1}, {1, 0}};
  int[][] P42= {{0, 0}, {0, -1}, {0, 1}, {-1, 0}};//---
  int[][] P43= {{0, 0}, {0, -1}, {0, 1}, {0, 2}}; // ----
  int[][] P44= {{0, 0}, {0, -1}, {0, 1}, {-1, -1}}; // l ---
  int[][] P45= {{0, 0}, {0, -1}, {1, 0}, {1, 1}}; //ss

  int[][] P51= {{0, 0}, {0, -2}, {0, -1}, {0, 1}, {0, 2}};
  int[][] P52= {{0, 0}, {0, -1}, {-1, -1}, {0, 1}, {0, 2}};
  int[][] P53= {{0, 0}, {0, -1}, {-1, 0}, {0, 1}, {0, 2}};  
  int[][] P54= {{0, 0}, {0, -1}, {1, -1}, {1, 0}, {1, 1}};
  int[][] P55= {{0, 0}, {0, -1}, {-1, -1}, {0, 1}, {-1, 1}};
  int[][] P56= {{0, 0}, {-1, 0}, {-1, -1}, {0, 1}, {0, 2}};
  int[][] P57= {{0, 0}, {0, 1}, {-1, 0}, {-2, 0}, {0, 2}};
  int[][] P58= {{0, 0}, {-1, 0}, {1, 0}, {1, -1}, {1, 1}};
  int[][] P59= {{0, 0}, {-1, 0}, {1, 0}, {0, -1}, {0, 1}};
  int[][] P510= {{0, 0}, {0, 1}, {0, -1}, {1, 0}, {-1, -1}};
  int[][] P511= {{0, 0}, {0, 1}, {0, -1}, {-1, -1}, {1, 1}};
  int[][] P512= {{0, 0}, {0, -1}, {1, 0}, {1, 1}, {-1, -1}};


  int _n ;
  int _estado=0;
  ArrayList<Monomino> arrayL = new ArrayList<Monomino>();
  Tablero tab;

  Polyomino(Tablero tablero, int n) {
    tab= tablero;
    arrayL = tablero.retornar();
    _n=n;
  }

  void agregarPolyomino(int fila, int columna, int tipo) {  ///Ya
    fila_inicial=fila;
    columna_inicial=columna;
    for (int i=0; i<_n; i++) {
      if (_n==4) {
        switch(tipo) {
        case 0: 
          arrayL.add(new Monomino(P43[i][0]+fila, P43[i][1]+columna, color(255), 0, 0)); 
          break;    
        case 1: 
          arrayL.add(new Monomino(P44[i][0]+fila, P44[i][1]+columna, color(237,28,36), 0, 0)); 
          break;      
        case 2:
          arrayL.add(new Monomino(P42[i][0]+fila, P42[i][1]+columna, color(0,162,232), 0, 0));
          break;
        case 3:
          arrayL.add(new Monomino(P41[i][0]+fila, P41[i][1]+columna, color(34,177,76), 0, 0));
          break;
        case 4:
          arrayL.add(new Monomino(P45[i][0]+fila, P45[i][1]+columna, color(127), 0, 0));
          break;
        case 5:
          arrayL.add(new Monomino(P44[i][0]+fila, P44[i][1]+columna, color(237,28,36), 0, 0));
          if (i==_n-1) { 
            reflejarPolyomino(); 
          }
          break;
        case 6:
          arrayL.add(new Monomino(P45[i][0]+fila, P45[i][1]+columna, color(127), 0, 0));
          if (i==_n-1) { 
            reflejarPolyomino(); 

          }
          break;
        }
      }
      if (_n==5) {
        switch(tipo) {
        case 0: 
          arrayL.add(new Monomino(P51[i][0]+fila, P51[i][1]+columna, color(237,28,36),0,0)); 
          break;
        case 1: 
          arrayL.add(new Monomino(P52[i][0]+fila, P52[i][1]+columna, color(255,127,39), 0, 0)); 
          break;
        case 2: 
          arrayL.add(new Monomino(P53[i][0]+fila, P53[i][1]+columna, color(34,177,76), 0, 0)); 
          break;
        case 3: 
          arrayL.add(new Monomino(P54[i][0]+fila, P54[i][1]+columna, color(0,162,232), 0, 0)); 
          break;
        case 4: 
          arrayL.add(new Monomino(P55[i][0]+fila, P55[i][1]+columna, color(163,73,164), 0, 0)); 
          break;
        case 5: 
          arrayL.add(new Monomino(P56[i][0]+fila, P56[i][1]+columna, color(127), 0, 0)); 
          break; 
         case 6: 
          arrayL.add(new Monomino(P57[i][0]+fila, P57[i][1]+columna, color(185,122,87), 0, 0)); 
          break;
          case 7: 
          arrayL.add(new Monomino(P58[i][0]+fila, P58[i][1]+columna, color(255,201,14), 0, 0)); 
          break;
          case 8: 
          arrayL.add(new Monomino(P59[i][0]+fila, P59[i][1]+columna, color(181,230,29), 0, 0)); 
          break;
          case 9: 
          arrayL.add(new Monomino(P510[i][0]+fila, P510[i][1]+columna, color(63,72,204), 0, 0)); 
          break;
          case 10: 
          arrayL.add(new Monomino(P511[i][0]+fila, P511[i][1]+columna, color(255), 0, 0)); 
          break;
          case 11: 
          arrayL.add(new Monomino(P512[i][0]+fila, P512[i][1]+columna, color(200, 191, 231), 0, 0)); 
          break;
          
          case 12:
          arrayL.add(new Monomino(P52[i][0]+fila, P52[i][1]+columna, color(255,127,39), 0, 0));
          if (i==_n-1) { 
            reflejarPolyomino(); 
          }
          break;
          case 13:
          arrayL.add(new Monomino(P53[i][0]+fila, P53[i][1]+columna, color(34,177,76), 0, 0));
          if (i==_n-1) { 
            reflejarPolyomino(); 
          }
          break;
          case 14:
          arrayL.add(new Monomino(P54[i][0]+fila, P54[i][1]+columna, color(0,162,232), 0, 0));
          if (i==_n-1) { 
            reflejarPolyomino(); 
          }
          break;
          
          case 15:
          arrayL.add(new Monomino(P56[i][0]+fila, P56[i][1]+columna, color(127), 0, 0));
          if (i==_n-1) { 
            reflejarPolyomino(); 
          }
          break;
          case 16:
          arrayL.add(new Monomino(P510[i][0]+fila, P510[i][1]+columna, color(63,72,204), 0, 0));
          if (i==_n-1) { 
            reflejarPolyomino(); 
          }
          break;
          case 17:
          arrayL.add(new Monomino(P511[i][0]+fila, P511[i][1]+columna, color(255), 0, 0));
          if (i==_n-1) { 
            reflejarPolyomino(); 
          }
          break;
          
        }
      }
    }
  }
  boolean moverPolyomino(int des_fila, int des_columna) {  //Ya
    Monomino operador = new Monomino(0, 0, 0, 0, 0); //Creamos el operador
    int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
    for (int i = cantidadCeldas-1; i>cantidadCeldas-1-_n; i--) { 
      operador = arrayL.get(i);
      operador.aumentarFila(des_fila);
      operador.aumentarColumna(des_columna);
    }
    if (interferencia()) {
      return true;
    }
    return false;
  }

  boolean reflejarPolyomino() {  //Ya
    Monomino operador = new Monomino(0, 0, 0, 0, 0); //Creamos el operador
    int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
    for (int i = cantidadCeldas-1; i>cantidadCeldas-1-_n; i--) { 
      operador = arrayL.get(i);
      operador.reflect();
    }
    if (interferencia()) {
      return true;
    } else {
      return false;
    }
  }

  boolean girarPolyomino() {  //Ya
    Monomino operador = new Monomino(0, 0, 0, 0, 0); //Creamos el operador
    int cantidadCeldas = arrayL.size(); //obtenemos el tamaño del array donde está el polyominó
    for (int i = cantidadCeldas-1; i>cantidadCeldas-1-_n; i--) { 
      operador = arrayL.get(i);
      operador.rotate();
    }

    if (interferencia()) {
      return true;
    } else {
      return false;
    }
  }

  boolean interferencia( ) {
    int  l_fila = tab._filas;
    int l_columna = tab._columnas;
    Monomino operador1 = new Monomino(0, 0, 0, 0, 0);
    Monomino operador2 = new Monomino(0, 0, 0, 0, 0);
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

  int[] obtener_centro() {
    int centrof, centroc;
    Monomino operador = new Monomino(0, 0, 0, 0, 0);
    int cantidadCeldas = arrayL.size(); 
    operador = arrayL.get(cantidadCeldas-_n);
    centrof = operador.getFila();
    centroc = operador.getColumna();
    //println("fila: " + centrof + " columna: " + centroc);
    int[] ret = {centrof, centroc}; 
    return ret;
  }
}
