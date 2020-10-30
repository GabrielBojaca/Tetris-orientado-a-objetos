int filas = 22;
int filas_pre = 22;
int columnas = 10;

int[][] tablero = new int[filas][columnas];  
int[][] previsualizacion = new int[filas][columnas];  
int[][][] colores = new int[filas][columnas][3];  

void setup(){  
  size(420,820);
  tablero[2][3]=1;
  tablero[3][5]=1;
  tablero[5][2]=1;
  tablero[4][8]=1;
  
}

void draw(){
  dibujarTablero(10,10,tablero,800,2);  
}

void dibujarTablero(int pos_x, int pos_y, int[][] tableau, int alto, int filas_ocultas){
 // int filas_ocultas = 2; 
   float ancho=(float(columnas)/float(filas-filas_ocultas))*alto;
  //println("factor :" + float(filas)/float(columnas));
  push();
  for(int i=0; i<=tableau.length-1;i++){ //Filas
    for(int j=0; j<=tableau[0].length-1;j++){ //Columna
     //println("Fila: " + i + " Columna: " + j); //debug 
     if(tableau[i][j]==1){fill(255,255,255); stroke(0,0,0);}
   else{fill(0,0,0); stroke(255);}
     if(i>filas_ocultas-1){
     rect((j*ancho/columnas)+pos_x,((i-filas_ocultas)*alto/(filas-filas_ocultas))+pos_y,ancho/columnas,alto/(filas-filas_ocultas));
     }
    }
  }
  pop();
}

void limpiarTablero(int[][] tableau){
   push();
  for(int i=0; i<=tableau.length-1;i++){ //Filas
    for(int j=0; j<=tableau[0].length-1;j++){ //Columna    
      tableau[i][j]=0;
    }
  }
  pop();
}

void keyPressed(){ 
  limpiarTablero(tablero);
}

class Monomino { 
  int pos_fila, pos_columna; 
  Monomino (int fila, int columna) {  
    pos_fila = fila; 
    pos_columna = columna; 
  } 
  void bajar() { 
    pos_fila++; 
  } 
  void subir() { 
    pos_fila--; 
  } 
  void derecha() { 
    pos_columna++; 
  } 
  void izquierda() { 
    pos_columna--; 
  } 
  
  int fila(){
   return pos_fila; 
  }
  int columna(){
   return pos_columna; 
  }

} 
