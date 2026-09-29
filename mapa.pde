class Mapa {

  int escala = 50;

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


  // Dibujar el mapa
  void mostrar() {

    rectMode(CORNER);

    fill(#D77643);

    for (int i = 0; i < paredes.length; i++) {

      float x = paredes[i][0] * escala;
      float y = paredes[i][1] * escala;

      float ancho = paredes[i][2] * escala;
      float alto = paredes[i][3] * escala;

      rect(x, y, ancho, alto);
    }
  }


  // Detectar colisiones
  boolean colisiona(float x, float y, float anchoTanque, float altoTanque) {

    for (int i = 0; i < paredes.length; i++) {

      float paredX = paredes[i][0] * escala;
      float paredY = paredes[i][1] * escala;

      float paredAncho = paredes[i][2] * escala;
      float paredAlto = paredes[i][3] * escala;


      if (x + anchoTanque / 2 > paredX &&
          x - anchoTanque / 2 < paredX + paredAncho &&
          y + altoTanque / 2 > paredY &&
          y - altoTanque / 2 < paredY + paredAlto) {

        return true;
      }
    }

    return false;
  }
