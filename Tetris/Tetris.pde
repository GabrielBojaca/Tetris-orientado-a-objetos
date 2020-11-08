int filas = 24;
int columnas = 11;

Tablero buf;
Tablero principal;
Tablero prev;
Polyomino ficha;
Polyomino prevFicha;
PImage fondoSet;
PImage fondoGo;
PImage letras;
int[][] buffint;
int[][] tableau ;  

int[][] previsualizacion;

ArrayList<Monomino> celdas = new ArrayList<Monomino>();
ArrayList<Monomino> buffer = new ArrayList<Monomino>();
ArrayList<Monomino> previo = new ArrayList<Monomino>();
ArrayList<Monomino> vacio = new ArrayList<Monomino>();





int fila_inicial, columna_inicial; //PELIGROSO
int orden_juego= 4;
int fila_origen;
int columna_origen;
//int cantidad_celdas = buffer.size();
int cantidad_celdas;
int tip=0;
int puntaje = 0;
int filas_eliminadas=0;
int comodines = 1;

int full;
int tiempo_caida = 500;
int tiempo_anterior;
int altura_prev;
int estado_config=0;


boolean choque_inferior = false;
boolean game_over=false;
boolean tomar_nueva = true;
boolean pantallaSet = true;
boolean pantallaPlay = false;
boolean enableComodines = true;
boolean enablePsycho = false;
boolean enableStroke = true;
boolean enableRandomGeo = false;
int randomGeoVal = 0;

void setup() {
  //frameRate(200);
  fondoSet = loadImage("fondo.jpg");
  fondoGo = loadImage("fondoplay.jpg");
  letras = loadImage("letras.png");
  size(1900, 1000); //Establecemos el tamaño de la ventana
}




void draw() {
 // println(frameRate);


  if (pantallaSet) {
    configuraciones();
    
  } 
  if (pantallaPlay) {

    
    play();
  }
}

void configuraciones() { //Determinar el grado del juego

  fill(255);
  image(fondoSet, 0, 0);

  if (enableComodines) {
    image(letras, 1500, 380, 200, 200);
  }
  if (enablePsycho) {
    image(letras, 1130, 280, 200, 200);
    enableRandomGeo = false;
    enableStroke = false;
  }
  if (enableStroke) {
    image(letras, 760, 295, 200, 200);
  }
  if (enableRandomGeo) {
    image(letras, 1490, 10, 200, 200);
  }




  switch(estado_config) {
  case 0:
    push();
    textAlign(CENTER, CENTER);
    textSize(80);
    text(filas-4, 850, 865);
    text(columnas, 1260, 865);
    text(orden_juego, 1650, 865);
    pop();
    break;

  case 1:  //SET

    //update(ArrayList<Monomino> partida, ArrayList<Monomino> llegada ) { //Se busca que llegada se vuelva igual a partida
    borrar(buffer);
    borrar(celdas);
    borrar(previo);
    //update(vacio, celdas);
    cantidad_celdas=0;
    game_over=false;
    comodines = 0;
    tiempo_caida = 500;
    buffint = new int[filas][columnas];
    tableau = new int[filas][columnas];  


    int alto= (height/((filas-4)+2))*(filas-4);
    buf = new Tablero(0, 0, 4, 0, buffer, buffint); //instanciamos el Buffer

    principal = new Tablero(325, height/((filas-4)+2), 4, alto, celdas, tableau); //Instanciamos tablero principal


    if (orden_juego == 4) {
      fila_origen = 1;
      columna_origen = columnas/2;
      previsualizacion = new int[4][6];
      altura_prev = 150;
    }
    if (orden_juego == 5) {
      fila_origen = 2;
      columna_origen = columnas/2;
      previsualizacion = new int[5][7];
      altura_prev = 188;
    }

    prev = new Tablero(850/filas, height/((filas-4)+2), 0, altura_prev, previo, previsualizacion); //Instanciamos tablero previo
    ficha = new Polyomino(buf, orden_juego); //instaciamos ficha de juego
    prevFicha = new Polyomino(prev, orden_juego);


    cantidad_celdas = buffer.size();
    ficha.agregarPolyomino(fila_origen, columna_origen, 0);
    buf.traducirTablero();
    update(buffer, celdas);
    tiempo_anterior=0;
    prev.llenarBordes();
    estado_config++;
    break;

  case 2:
    pantallaSet = false;
    image(fondoGo, 0, 0);
    break;
  }



  //  println(pantallaSet);
}

void play() {  
  fill(255);
  rect(850/filas,height/((filas-4)+2)+200,240,110);
  fill(0);
  textSize(40);
  textAlign(CENTER,CENTER);
  text("Puntaje: " ,(850/filas)+125, height/((filas-4)+2)+200+25);
  text(puntaje,(850/filas)+125, height/((filas-4)+2)+200+30+50);
  
  fill(255);
  rect(850/filas,height/((filas-4)+2)+320,240,90);
  fill(0);
  textSize(29);
  textAlign(CENTER,CENTER);
  text("Filas eliminadas: " ,(850/filas)+125, height/((filas-4)+2)+320+20);
  textSize(40);
  text(filas_eliminadas,(850/filas)+125, height/((filas-4)+2)+320+55);
  
  fill(255);
  rect(850/filas,height/((filas-4)+2)+320+100,240,90);
  fill(0);
  textSize(29);
  textAlign(CENTER,CENTER);
  text("Nivel" ,(850/filas)+125, height/((filas-4)+2)+320+20+100);
  textSize(40);
  text((filas_eliminadas/10)+1,(850/filas)+125, height/((filas-4)+2)+320+55+100);
  
  if(enableComodines){
  fill(255);
  rect(850/filas,height/((filas-4)+2)+320+100+100,240,90);
  fill(0);
  textSize(29);
  textAlign(CENTER,CENTER);
  text("Comodin" ,(850/filas)+125, height/((filas-4)+2)+320+20+100+100);
  textSize(40);
  text(comodines,(850/filas)+125, height/((filas-4)+2)+320+55+100+100);
  }
  
  
  
  if (game_over==true) {
    pantallaPlay=false; 
    pantallaSet=true; 
    estado_config = 0;
    choque_inferior = false;
  }

  if (tomar_nueva) {
    if (orden_juego==4) {
      tip=int(random(0, 8));
      if (tip==0) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 2, tip);
      }
      if (tip==1) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 2, tip);
      }
      if (tip==2) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 2, tip);
      }
      if (tip==3) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(1, 3, tip);
      }
      if (tip==4) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(1, 2, tip);
      }
      if (tip==5) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 2, tip);
      }
      if (tip==6) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(1, 2, tip);
      }
    }
    if (orden_juego==5) {
      tip=int(random(0, 18));
      if (tip==0) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
      if (tip==1) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
      if (tip==2) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
      if (tip==3) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(1, 3, tip);
      }
      if (tip==4) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
      if (tip==5) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
      if (tip==6) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(3, 2, tip);
      }
      if (tip==7) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
      if (tip==8) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
      if (tip==9) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
      if (tip==10) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
      if (tip==11) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }      
      if (tip==12) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 4, tip);
      }
      if (tip==13) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 4, tip);
      }
      if (tip==14) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(1, 3, tip);
      }
      if (tip==15) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 4, tip);
      }
      if (tip==16) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
      if (tip==17) {
        prev.borrarInterno();
        prevFicha.agregarPolyomino(2, 3, tip);
      }
    }
    tomar_nueva = false;
    fila_inicial = fila_origen;
    columna_inicial = columna_origen;
  }


  if (choque_inferior ==true && game_over==false) {  
    tiempo_caida -= 5;
    if (buf.identificarFilas().length>0) {
      filas_eliminadas += buf.identificarFilas().length;
      randomGeoVal += int(random(1, 3));
      randomGeoVal %=5;
      comodines += buf.identificarFilas().length;
      puntaje += 100 * pow(2, buf.identificarFilas().length);
      buf.quitarFilas(buf.identificarFilas());
      update(buffer, celdas);
    }
    cantidad_celdas = buffer.size();


    fila_inicial = fila_origen;
    columna_inicial = columna_origen;
    ficha.agregarPolyomino(fila_origen, columna_origen, tip);
    choque_inferior = false; 
    tomar_nueva = true;
  }

  if (millis()-tiempo_anterior>tiempo_caida) {
    cantidad_celdas = buffer.size();
    if (!game_over) {
      if (ficha.moverPolyomino(1, 0)) { //Hay interferencia?
        update(celdas, buffer); //Buffer se vuelve celdas
        comprobarGame_over(buffer);
        choque_inferior=true;
      } else {
        update(buffer, celdas); //Celdas e vuelve buffer
      }
    }
    tiempo_anterior=millis();
  }

  buf.traducirTablero();
  principal.traducirTablero();
  principal.dibujarTablero(enableStroke, enablePsycho, enableRandomGeo, randomGeoVal);
  prev.traducirTablero();
  prev.dibujarTablero(true, enablePsycho, false, 0);

 

  if (keyPressed) {

    cantidad_celdas = buffer.size();

    if ((key == 's' || key == 'S') && !game_over) {
      puntaje+=1;
      if (ficha.moverPolyomino(1, 0)) { //Hay interferencia?
        update(celdas, buffer); //Buffer se vuelve celdas
        comprobarGame_over(buffer);
        choque_inferior=true;
      } else {
        update(buffer, celdas); //Celdas e vuelve buffer
      }
      key = ' ';
    } else if ((comodines>0) && (key == 'w' || key == 'W') && !game_over) {    
      comodines-=1;
      background(255);
      image(fondoGo, 0, 0);
      if (ficha.moverPolyomino(-1, 0)) { //Hay interferencia?
        update(celdas, buffer); //Buffer se vuelve celdas
      } else {
        update(buffer, celdas); //Celdas e vuelve buffer
      }
      key = ' ';
    } else if ((key == 'd' || key == 'D') && !game_over) {
      if (ficha.moverPolyomino(0, 1)) { //Hay interferencia?
        update(celdas, buffer); //Buffer se vuelve celdas
      } else {
        update(buffer, celdas); //Celdas e vuelve buffer
      }
      key = ' ';
    } else if ((key == 'a' || key == 'A') && !game_over) {

      if (ficha.moverPolyomino(0, -1)) { //Hay interferencia?
        update(celdas, buffer); //Buffer se vuelve celdas
      } else {
        update(buffer, celdas); //Celdas e vuelve buffer
      }
      key = ' ';
    } else if ((key == 'q' || key == 'Q') && !game_over && (ficha.obtener_centro()[0]!=fila_origen || ficha.obtener_centro()[1]!=columna_origen)) {
      if (ficha.girarPolyomino()) { //Hay interferencia?
        update(celdas, buffer); //Buffer se vuelve celdas
      } else {
        update(buffer, celdas); //Celdas e vuelve buffer
      }
      key = ' ';
    } else if ((comodines>0) && (key == 'e' || key == 'E') && !game_over && (ficha.obtener_centro()[0]!=fila_origen || ficha.obtener_centro()[1]!=columna_origen)) {
      comodines-=1;
      background(255);
      image(fondoGo, 0, 0);
      if (ficha.reflejarPolyomino()) { //Hay interferencia?
        update(celdas, buffer); //Buffer se vuelve celdas
      } else {
        update(buffer, celdas); //Celdas e vuelve buffer
      }
      key = ' ';
    }
    //}
  }
}

void keyPressed() {

  if ((key == 'q' || key == 'Q')&& pantallaSet) {
    filas+=1;
    key = ' ';
  }
  if ((key == 'a' || key == 'A')&& pantallaSet) {
    filas-=1;
    key = ' ';
  }

  if ((key == 'e' || key == 'E')&& pantallaSet) {
    columnas+=1;
    if(columnas>32){columnas = 32;}
    key = ' ';
  }

  if ((key == 'd' || key == 'D')&& pantallaSet) {
    columnas-=1;
    if(columnas<8){columnas=8;}
    key = ' ';
  }

  if ((key == 'w' || key == 'D')&& pantallaSet) {
    orden_juego +=1;
    if (orden_juego>5) {
      orden_juego=5;
    }  
    key = ' ';
  }

  if ((key == 's' || key == 'D')&& pantallaSet) {
    orden_juego -=1;
    if (orden_juego<4) {
      orden_juego=4;
    } 
    key = ' ';
  }

  if ((key == 'p' || key == 'P')&& pantallaSet) {
    estado_config = 1;
    pantallaPlay = true;
  }

  if ((key == 'r' || key == 'R')&& pantallaSet) {
    enableComodines = !enableComodines;
  }
  if ((key == 't' || key == 'T')&& pantallaSet) {
    enablePsycho = !enablePsycho;
  }
  if ((key == 'y' || key == 'Y')&& pantallaSet) {
    enableStroke = !enableStroke;
  }

  if ((key == 'u' || key == 'U')&& pantallaSet) {
    enableRandomGeo = !enableRandomGeo;
    enablePsycho = false;
  }
}
void update(ArrayList<Monomino> partida, ArrayList<Monomino> llegada ) { //Se busca que llegada se vuelva igual a partida
  Monomino operador = new Monomino(0, 0, 0, 0, 0); 
  //Borramos todo de llegada
  int cantidad_inicial = llegada.size(); //Obtenemos el tamaño del array de llegada
  for (int i=0; i<=cantidad_inicial; i++) { 
    if (llegada.size()>0) {
      llegada.remove(0);
    } //Borramos todos los elementos del conjunto de llegada
  }

  for (int i=0; i<=partida.size()-1; i++) { //Agregamos todos los elementos de partida a llegada
    operador = partida.get(i);
    llegada.add(new Monomino(operador.getFila(), operador.getColumna(), operador.getColor(), operador.getAu_F(), operador.getAu_C()));
  }
}

void borrar(ArrayList<Monomino> llegada ) { //Borrar
  int cantidad_inicial = llegada.size(); //Obtenemos el tamaño del array de llegada
  for (int i=0; i<=cantidad_inicial; i++) { 
    if (llegada.size()>0) {
      llegada.remove(0);
    } //Borramos todos los elementos del conjunto de llegada
  }
}



void comprobarGame_over(ArrayList<Monomino> arrayL) {
  if (cantidad_celdas > arrayL.size()) {
    game_over = true;
  }



  if (ficha.obtener_centro()[0]==fila_origen && ficha.obtener_centro()[1]==columna_origen ||
    ficha.obtener_centro()[0]==fila_origen+1 && ficha.obtener_centro()[1]==columna_origen) {
    if (ficha.interferencia()) {
      game_over = true;
    }
  }
  if (game_over) {
    background(255);
  }
}
