class Mapa {

  int escalaX = 50;
  int escalaY = 50;

  PImage metal;
  // Cada fila tiene:
  // {posX, posY, ancho, alto}

  int[][] paredes = {
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
  Mapa() {
    metal = loadImage("metal.png");
    metal.resize(escalaX,escalaY);
    
  }

  // Dibujar el mapa
  void mostrar() {

    imageMode(CORNER);

    for (int i = 0; i < paredes.length; i++) {
      int x = paredes[i][0] * escalaX;
      int y = paredes[i][1] * escalaY;
      int ancho = paredes[i][2] * escalaX;
      int alto = paredes[i][3] * escalaY;

      for (int px = x; px < x + ancho; px += escalaX) {
        for (int py = y; py < y + alto; py += escalaY) {
          image(metal, px, py);
        }
      }
    }
  }


  // Detectar colisiones
  boolean colisiona(float x, float y, float anchoTanque, float altoTanque) {

    for (int i = 0; i < paredes.length; i++) {

      float paredX = paredes[i][0] * escalaX;
      float paredY = paredes[i][1] * escalaY;

      float paredAncho = paredes[i][2] * escalaX;
      float paredAlto = paredes[i][3] * escalaY;


      if (x + anchoTanque / 2 > paredX &&
        x - anchoTanque / 2 < paredX + paredAncho &&
        y + altoTanque / 2 > paredY &&
        y - altoTanque / 2 < paredY + paredAlto) {

        return true;
      }
    }

    return false;
  }
}
