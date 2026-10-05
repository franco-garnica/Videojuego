class Tanque2 {

  float x;
  float y;

  float velocidad = 3;

  float ancho = 28;
  float alto = 28;

  PImage img; // Variable para almacenar su imagen propia

  Tanque2(float x, float y, PImage img) {
    this.x = x;
    this.y = y;
    this.img = img; // Guardamos la imagen
  }

  void mover(float otroX, float otroY, float otroAncho, float otroAlto) {

    float nuevoX = x;
    float nuevoY = y;

    if (keyPressed && key == CODED) {
      if (keyCode == UP)    nuevoY -= velocidad;
      if (keyCode == DOWN)  nuevoY += velocidad;
      if (keyCode == LEFT)  nuevoX -= velocidad;
      if (keyCode == RIGHT) nuevoX += velocidad;
    }

    boolean colParedX = mapa.colisiona(nuevoX, y, ancho, alto);
    boolean colTanqueX = colisionEntreTanques(nuevoX, y, ancho, alto, otroX, otroY, otroAncho, otroAlto);

    if (!colParedX && !colTanqueX) {
      x = nuevoX;
    }

    boolean colParedY = mapa.colisiona(x, nuevoY, ancho, alto);
    boolean colTanqueY = colisionEntreTanques(x, nuevoY, ancho, alto, otroX, otroY, otroAncho, otroAlto);

    if (!colParedY && !colTanqueY) {
      y = nuevoY;
    }

    x = constrain(x, ancho/2, width - ancho/2);
    y = constrain(y, alto/2, height - alto/2);
  }

  void mostrar() {
    imageMode(CENTER);
    image(img, x, y, 40, 40); // Dibujamos su imagen sin tintes
  }
}
