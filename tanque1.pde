class Tanque1 {

  float x;
  float y;

  float velocidad = 3;

  float ancho = 28;
  float alto = 28;

  float angulo = 0;

  Tanque1(float xInicial, float yInicial) {
    x = xInicial;
    y = yInicial;
  }

  void mover() {

    float movimientoX = 0;
    float movimientoY = 0;

    if (keyPressed) {
      if (key == 'a' || key == 'A') movimientoX -= 1;
      if (key == 'd' || key == 'D') movimientoX += 1;
      if (key == 'w' || key == 'W') movimientoY -= 1;
      if (key == 's' || key == 'S') movimientoY += 1;
    }

    // Evita que el movimiento diagonal sea más rápido
    if (movimientoX != 0 && movimientoY != 0) {
      movimientoX *= 0.7071;
      movimientoY *= 0.7071;
    }

    float nuevoX = x + movimientoX * velocidad;
    float nuevoY = y + movimientoY * velocidad;

    // Gira el tanque según la dirección del movimiento
    if (movimientoX != 0 || movimientoY != 0) {
      angulo = atan2(movimientoY, movimientoX);
    }

    nuevoX = constrain(nuevoX, ancho / 2, width - ancho / 2);
    nuevoY = constrain(nuevoY, alto / 2, height - alto / 2);

    // Colisión con las paredes
    if (!mapa.colisiona(nuevoX, y, ancho, alto)) {
      x = nuevoX;
    }

    if (!mapa.colisiona(x, nuevoY, ancho, alto)) {
      y = nuevoY;
    }
  }

  void mostrar() {

    imageMode(CENTER);

    pushMatrix();

    translate(x, y);
    rotate(angulo);

    image(imagenTanque1, 0, 0, 40, 40);

    popMatrix();
  }
}
