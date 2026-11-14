class Mapa {

  PImage metal, imagenPasto;
  
  float escalaX, escalaY; // tamaño de casillas segun pantalla

  // Posición X, posición Y, ancho y alto
  float[][] paredes = {
    {1, 1, 1, 6},
    {4, 1, 1, 6},
    {7, 1, 1, 4},
    {10, 1, 1, 4},
    {13, 1, 1, 6},
    {7, 6, 1, 1},
    {10, 6, 1, 1},
    {1, 8, 4, 1},
    {7, 8, 4, 3},
    {12, 8, 3, 1},
    {1, 10, 1, 5},
    {4, 10, 1, 4},
    {13, 10, 1, 5},
    {7, 12, 4, 3}
  };

//constructor
  Mapa() {
    escalaX = width / 16.0;
    escalaY = height / 16.0; 
// dividido 16, tanto columnas como filas

    metal = loadImage("Metal.png");
    metal.resize((int)escalaX, (int) escalaY);
    imagenPasto = loadImage("Pasto.png");
  }

//dibuja paredes
  void mostrar() { 

    imageMode(CORNER);
    image(imagenPasto, 0, 0, width, height); //pega la imagen en base a la pantalla

    for (int i = 0; i < paredes.length; i++) { //recorre paredes


      float x = paredes[i][0] * escalaX;
      float y = paredes[i][1] * escalaY;
      float ancho = paredes[i][2] * escalaX;
      float alto = paredes[i][3] * escalaY;
      //calcula tanto posicion como tamaño
     
      for (float px = x; px < x + ancho; px += escalaX) {
      for (float py = y; py < y + alto; py += escalaY) {
        //dibuja los casilleros que forma la pared
          image(metal, px, py, escalaX, escalaY);
        }
      }
    }
  }

//ve si el tanque choca contra una pared
  boolean colisiona(float x, float y, float ancho, float alto) {

    for (int i = 0; i < paredes.length; i++) {
//recorre paredes

      float px = paredes[i][0] * escalaX;
      float py = paredes[i][1] * escalaY;
      float pw = paredes[i][2] * escalaX;
      float ph = paredes[i][3] * escalaY;
//calcula tanto posicion como tamaño actual de la pared

      if (x + ancho/2 > px && x - ancho/2 < px + pw &&
          y + alto/2 > py && y - alto/2 < py + ph) {
            //revisa si el tanque choco con una pared
            
        return true;// si choco
      }
    }
  return false; // no choco
  }
}
