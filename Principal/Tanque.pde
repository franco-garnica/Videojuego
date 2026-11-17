
class Tanque1 {

  PImage imagenTanque1;

  float x;
  float y;
  float velocidad = 4;

  float ancho = 33;
  float alto = 25;

  float angulo = 0;

  int vidas = 3;


  // Constructor
  Tanque1(float xInicial, float yInicial, int skin) {

    x = xInicial;
    y = yInicial;

    if (skin == 0) {
      imagenTanque1 = loadImage("TanqueEje.png");
    } else {
      imagenTanque1 = loadImage("TanqueAliados.png");
    }

    // Cambiar tamaño de la imagen
    imagenTanque1.resize(120, 120);
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

    float nuevoX = x + movimientoX * velocidad;
    float nuevoY = y + movimientoY * velocidad;

    // Girar según la dirección
    if (movimientoX != 0 || movimientoY != 0) {
      angulo = atan2(movimientoX, movimientoY);
    }

    // Evitar salir de la pantalla
    nuevoX = constrain(nuevoX, ancho / 2, width - ancho / 2);
    nuevoY = constrain(nuevoY, alto / 2, height - alto / 2);

    // Comprobar colisiones
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

    image(imagenTanque1, 0, 0);

    popMatrix();
  }
}
