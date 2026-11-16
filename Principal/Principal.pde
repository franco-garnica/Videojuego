int estadoJuego = 0;
int skinElegida = 0;
Menu menu;
Mapa mapa;
Tanque1 tanque1;
Torreta torreta;
Interfaz interfaz;

ArrayList<Proyectil> proyectiles = new ArrayList<Proyectil>();

void setup() {
  fullScreen(P2D);
//size(800,800);

  menu = new Menu();
  mapa = new Mapa();
  tanque1 = new Tanque1(600, 600, skinElegida);
  torreta = new Torreta();
  torreta.tanque = tanque1;
  interfaz = new Interfaz();
}

void draw() {
  if (estadoJuego == 0) {
    menu.mostrar();
  } else if (estadoJuego == 1) {
    
    background(0);
    
    imageMode(CORNER);
    mapa.mostrar();
    
    tanque1.mover();
    torreta.mover();

    tanque1.mostrar();
    torreta.mostrar();
    interfaz.mostrarVidas(tanque1);

    for (int i = 0; i < proyectiles.size(); i++) {
      Proyectil p = proyectiles.get(i);
      p.mover();
      p.mostrar();
    }
  }
}

void mousePressed() {
  if (estadoJuego == 0) {
    menu.comprobarBoton();
  } else if (estadoJuego == 1 && mouseButton == LEFT) {
    float angulo = atan2(
      mouseY - tanque1.y,
      mouseX - tanque1.x
      );
    proyectiles.add(
      new Proyectil(tanque1.x, tanque1.y, angulo)
      );
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    tanque1 = new Tanque1(600, 600, skinElegida);
  torreta = new Torreta();
torreta.tanque = tanque1;
    proyectiles.clear();
  }
}
