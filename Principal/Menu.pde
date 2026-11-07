
class Menu {

  PImage fondo;

  // Posición y tamaño del botón
  float botonX = 600;
  float botonY = 690;

  float botonAncho = 250;
  float botonAlto = 75;


  Menu() {
    fondo = loadImage("Fondo.png");
  }


  void mostrar() {

    // Dibujar fondo
    imageMode(CORNER);
    image(fondo, 0, 0, width, height);

    // Comprobar si el mouse está sobre el botón
    boolean mouseEncima =
      mouseX > botonX &&
      mouseX < botonX + botonAncho &&
      mouseY > botonY &&
      mouseY < botonY + botonAlto;

    // Sombra del botón
    noStroke();
    fill(0, 150);
    rect(
      botonX + 5,
      botonY + 6,
      botonAncho,
      botonAlto,
      12
    );

    // Color del botón
    if (mouseEncima) {
      fill(#70C94B);
    } else {
      fill(#398D32);
    }

    // Borde metálico
    stroke(#C5C5C5);
    strokeWeight(4);

    rect(
      botonX,
      botonY,
      botonAncho,
      botonAlto,
      12
    );

    // Texto JUGAR
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);

    text(
      "JUGAR",
      botonX + botonAncho / 2,
      botonY + botonAlto / 2
    );

    noStroke();
  }


  // Comprobar clic en el botón
  void comprobarBoton() {

    if (mouseX > botonX &&
        mouseX < botonX + botonAncho &&
        mouseY > botonY &&
        mouseY < botonY + botonAlto) {

      estadoJuego = 1;
    }
  }
}
