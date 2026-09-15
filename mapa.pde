class Mapa {

  int escala;

  // Posición X de cada pared
  int[] posX = {
    1, 4, 7, 10, 13,
    7, 10,
    1, 7, 12,
    1, 4, 13,
    7
  };

  // Posición Y de cada pared
  int[] posY = {
    1, 1, 1, 1, 1,
    6, 6,
    8, 8, 8,
    10, 10, 10,
    12
  };

  // Cantidad de cuadrados de ancho
  int[] ancho = {
    1, 1, 1, 1, 1,
    1, 1,
    4, 4, 3,
    1, 1, 1,
    4
  };

  // Cantidad de cuadrados de alto
  int[] alto = {
    6, 6, 4, 4, 6,
    1, 1,
    1, 3, 1,
    5, 4, 5,
    3
  };

  Mapa() {

    // El mapa está dividido en 16 x 16
    escala = width / 16;
  }

  void mostrar() {

    rectMode(CORNER);

    fill(#D77643);

    for (int i = 0; i < posX.length; i++) {

      float x = posX[i] * escala;
      float y = posY[i] * escala;

      float w = ancho[i] * escala;
      float h = alto[i] * escala;

      rect(x, y, w, h);
    }
  }

  boolean colisiona(
    float x,
    float y,
    float anchoTanque,
    float altoTanque
    ) {

    for (int i = 0; i < posX.length; i++) {

      float paredX = posX[i] * escala;
      float paredY = posY[i] * escala;

      float paredAncho = ancho[i] * escala;
      float paredAlto = alto[i] * escala;

      // Comprobamos si el tanque toca la pared
      if (
        x + anchoTanque / 2 > paredX &&
        x - anchoTanque / 2 < paredX + paredAncho &&
        y + altoTanque / 2 > paredY &&
        y - altoTanque / 2 < paredY + paredAlto
        ) {

        return true;
      }
    }

    return false;
  }
}  
