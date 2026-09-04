// Estados del juego: 0 = Menu, 1 = Jugando
int estadoJuego = 0;

Menu menu;
Mapa mapa;
Tanque tanque1;
Tanque2 tanque2;

PImage imagenTanque1;
PImage imagenTanque2;

void setup() {
  size(800, 800);

  imagenTanque1 = loadImage("tanque1.png");
  imagenTanque2 = loadImage("tanque2.png");

  menu = new Menu();
  mapa = new Mapa();
  tanque1 = new Tanque(600, 600, imagenTanque1);
  tanque2 = new Tanque2(150, 200, imagenTanque2);
}

void draw() {
  background(50);

  if (estadoJuego == 0) {
    // Mostramos el menú
    menu.mostrar();
  } else if (estadoJuego == 1) {
    // Mostramos el juego
    mapa.mostrar();

    tanque1.mover(tanque2.x, tanque2.y, tanque2.ancho, tanque2.alto);
    tanque1.mostrar();

    tanque2.mover(tanque1.x, tanque1.y, tanque1.ancho, tanque1.alto);
    tanque2.mostrar();
  }
}

// Detecta el clic para el botón de iniciar
void mousePressed() {
  if (estadoJuego == 0) {
    menu.comprobarBoton();
  }
}

boolean colisionEntreTanques(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  return (x1 + w1/2 > x2 - w2/2 &&
          x1 - w1/2 < x2 + w2/2 &&
          y1 + h1/2 > y2 - h2/2 &&
          y1 - h1/2 < y2 + h2/2);
}
