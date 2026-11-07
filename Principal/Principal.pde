int estadoJuego = 0;
Menu menu;
Mapa mapa;
Tanque1 tanque1;
Torreta torreta;

PImage imagenTanque1;
PImage imagenPasto;
PImage imagenTorreta;

ArrayList<Proyectil> proyectiles = new ArrayList<Proyectil>();

void setup() {
  fullScreen(P2D);
  //frameRate(60);

  imagenTanque1 = loadImage("TanquePesado.png");
  imagenTanque1.resize(120, 120);
  imagenPasto = loadImage("pasto.png");
  imagenPasto.resize(width, height);
  imagenTorreta = loadImage("Torreta.png");
  imagenTorreta.resize(100, 100);

  menu = new Menu();
  mapa = new Mapa();
  tanque1 = new Tanque1(600, 600);
  torreta = new Torreta(tanque1);
}

void draw() {
  if (estadoJuego == 0) {
    menu.mostrar();
  } else if (estadoJuego == 1) {
    imageMode(CORNER);
    image(imagenPasto, 0, 0);
    mapa.mostrar();

    tanque1.mover();
    torreta.mover();

    tanque1.mostrar();
    torreta.mostrar();

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
    tanque1 = new Tanque1(600, 600);
    torreta = new Torreta(tanque1);
    proyectiles.clear();
  }
}
