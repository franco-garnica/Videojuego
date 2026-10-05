class Menu {

  // Posición y tamaño del botón
  float botonX = 300;
  float botonY = 420;

  float botonAncho = 200;
  float botonAlto = 60;


  Menu() {
  }


  void mostrar() {

    // Título
    textAlign(CENTER, CENTER);

    textSize(50);

    fill(255);

    text(
      "JUEGO DE TANQUES",
      width / 2,
      250
    );


    // Botón
    fill(#4CAF50);

    rect(
      botonX,
      botonY,
      botonAncho,
      botonAlto,
      10
    );


    // Texto del botón
    fill(255);

    textSize(24);

    text(
      "JUGAR",
      botonX + botonAncho / 2,
      botonY + botonAlto / 2
    );
  }


  // Comprueba si se hizo clic en el botón
  void comprobarBoton() {

    if (mouseX > botonX &&
        mouseX < botonX + botonAncho &&
        mouseY > botonY &&
        mouseY < botonY + botonAlto) {

      estadoJuego = 1;
    }
  }
}
