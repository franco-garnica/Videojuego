class Menu {
  
  // Posición y tamaño del botón
  float botonX = 300;
  float botonY = 420;
  float botonAncho = 200;
  float botonAlto = 60;

  Menu() {
  }

  void mostrar() {
    // Título del juego
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(255);
    text("JUEGO DE TANQUES", width / 2, 250);

    // Dibujar botón de Inicio
    fill(#4CAF50); // Color verde
    rect(botonX, botonY, botonAncho, botonAlto, 10); // 10 de borde redondeado

    // Texto dentro del botón
    fill(255);
    textSize(24);
    text("JUGAR", botonX + botonAncho / 2, botonY + botonAlto / 2);
  }

  // Cambia el estado del juego si el clic ocurre dentro del botón
  void comprobarBoton() {
    if (mouseX > botonX && mouseX < botonX + botonAncho &&
        mouseY > botonY && mouseY < botonY + botonAlto) {
      estadoJuego = 1; // Pasa al modo de juego
    }
  }
}
