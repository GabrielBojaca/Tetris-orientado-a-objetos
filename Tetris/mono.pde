class Monomino { 
  int pos_fila, pos_columna, num_tablero, _r, _g, _b, aumento_fila=0, aumento_columna=0;
  color _c ;

  Monomino (int fila, int columna, color c, int au_fila, int au_col) {  
    pos_fila = fila; 
    pos_columna = columna;    
    aumento_fila=au_fila;
    aumento_columna = au_col;
    _c=c;
  }

  void reflect() {
    int k = fila_inicial+aumento_fila;
    int j = columna_inicial + aumento_columna;  
    pos_fila = pos_fila-k; //levamos al origen
    pos_columna = pos_columna-j; //levamos al origen

    pos_columna = -pos_columna;
    pos_fila = pos_fila + k;
    pos_columna = pos_columna + j;
  }

  void rotate() {
    int k = fila_inicial+aumento_fila;
    int j = columna_inicial + aumento_columna;  
    pos_fila = pos_fila-k; //llevamos al origen
    pos_columna = pos_columna-j; //llevamos al origen
    int buffer;
    buffer = pos_fila;

    pos_fila = pos_columna;
    pos_columna = buffer;

    pos_columna = -pos_columna;   
    pos_fila = pos_fila + k;
    pos_columna = pos_columna + j;
  }

  void aumentarFila(int x) {     
    pos_fila+= x;
    aumento_fila+=x;
  } 
  void aumentarColumna(int x) { 
    pos_columna+=x;
    aumento_columna += x;
  } 

  int getFila() {
    return pos_fila;
  }
  int getColumna() {
    return pos_columna;
  }
  int[] getFC() {
    int [] _FC = {pos_fila, pos_columna};
    return _FC;
  }

  int getAu_F() {
    return aumento_fila;
  }
  int getAu_C() {
    return aumento_columna;
  }
  
  color getColor() {
    return _c;
  }


} 
